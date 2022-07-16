Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213255771A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jul 2022 23:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiGPVsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jul 2022 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGPVsT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jul 2022 17:48:19 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AD18E13;
        Sat, 16 Jul 2022 14:48:18 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658008095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x3HXgQUrco41LDbc708fhSxzFK309rLRf0po+Yszzrw=;
        b=eCdBgF63tI6bMObcpQ2Y+ue1cynT4Jr8YlUT8CmT88+KL0ZW5coTxvgDrWRKX0eWg+R9XG
        pAOeZUmflMafSfx6A4PQQXlBtoyV3SsnNpBSBlNL+gWLnU3/za90g0hILCXV5Yc4rzKB6w
        8Z2sLk2hjVwpKt6sYGVst9+JhM6176I=
Date:   Sat, 16 Jul 2022 21:48:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   oliver.upton@linux.dev
Message-ID: <385aa28ad559874da8429c40a68570df@linux.dev>
Subject: Re: [PATCH v2] KVM: selftests: Fix target thread to be migrated
 in rseq_test
To:     "Gavin Shan" <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, seanjc@google.com,
        pbonzini@redhat.com, maz@kernel.org, shuah@kernel.org,
        shan.gavin@gmail.com
In-Reply-To: <20220716144537.3436743-1-gshan@redhat.com>
References: <20220716144537.3436743-1-gshan@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gavin,=0A=0AThanks for cleaning this up.=0A=0AJuly 16, 2022 7:45 AM, "=
Gavin Shan" <gshan@redhat.com> wrote:=0A> In rseq_test, there are two thr=
eads, which are thread group leader=0A> and migration worker. The migrati=
on worker relies on sched_setaffinity()=0A> to force migration on the thr=
ead group leader.=0A=0AIt may be clearer to describe it as a vCPU thread =
and a migration worker=0Athread. The meat of this test is to catch a regr=
ession in KVM.=0A=0A> Unfortunately, we have=0A=0As/we have/the test has =
the/=0A=0A> wrong parameter (0) passed to sched_getaffinity().=0A=0Awrong=
 PID=0A=0A> It's actually=0A> forcing migration on the migration worker i=
nstead of the thread group=0A> leader.=0A=0AWhat's missing is _why_ the m=
igration worker is getting moved around by=0Athe call. Perhaps instead it=
 is better to state what a PID of 0 implies,=0Afor those of us who haven'=
t read their manpages in a while ;-)=0A=0A> It also means migration can h=
appen on the thread group leader=0A> at any time, which eventually leads =
to failure as the following logs=0A> show.=0A> =0A> host# uname -r=0A> 5.=
19.0-rc6-gavin+=0A> host# # cat /proc/cpuinfo | grep processor | tail -n =
1=0A> processor : 223=0A> host# pwd=0A> /home/gavin/sandbox/linux.main/to=
ols/testing/selftests/kvm=0A> host# for i in `seq 1 100`; \=0A> do echo "=
--------> $i"; ./rseq_test; done=0A> --------> 1=0A> --------> 2=0A> ----=
----> 3=0A> --------> 4=0A> --------> 5=0A> --------> 6=0A> =3D=3D=3D=3D =
Test Assertion Failure =3D=3D=3D=3D=0A> rseq_test.c:265: rseq_cpu =3D=3D =
cpu=0A> pid=3D3925 tid=3D3925 errno=3D4 - Interrupted system call=0A> 1 0=
x0000000000401963: main at rseq_test.c:265 (discriminator 2)=0A> 2 0x0000=
ffffb044affb: ?? ??:0=0A> 3 0x0000ffffb044b0c7: ?? ??:0=0A> 4 0x000000000=
0401a6f: _start at ??:?=0A> rseq CPU =3D 4, sched CPU =3D 27=0A> =0A> Thi=
s fixes the issue by passing correct parameter, tid of the group=0A> thre=
ad leader, to sched_setaffinity().=0A=0AKernel commit messages should hav=
e an imperative tone:=0A=0AFix the issue by ...=0A=0A> Fixes: 61e52f1630f=
5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration =
bugs")=0A> Signed-off-by: Gavin Shan <gshan@redhat.com>=0A=0AWith the com=
ments on the commit message addressed:=0A=0AReviewed-by: Oliver Upton <ol=
iver.upton@linux.dev>
