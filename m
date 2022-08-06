Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811BA58B520
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 13:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiHFLIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Aug 2022 07:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiHFLIN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Aug 2022 07:08:13 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD6EE38;
        Sat,  6 Aug 2022 04:08:10 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oKHf4-005H9H-N1; Sat, 06 Aug 2022 13:08:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Message-Id:In-Reply-To:Date:Subject:CC:To:From:MIME-Version:
        Content-Transfer-Encoding:Content-Type;
        bh=4k4hrKfuKMWTUDyGqGN1lIamEwVduqLB33bUAdj0r8c=; b=XZFxd3Pb8OTvVOLg3kWw+3fg3u
        bA0o1gNWlSN+gfLPr41aKhdIsZHFJBCMeyU5Il5W/DJJ34LXaL9oGZIHNqtYcJBZe7JJ5V+N4sLXa
        i10ukM1uGEp/YitBsQ0m6PyHAXPX8aJsYcdkLgqSJpHkpGefo4oBjFfnOSzS+D/cIDDR5TZWc1hfP
        vcSvtGGInAGONkfIPp2V1a9ag+rvRJ14PU2auLNMrFRwdLPJmh+zBvMAQ+56MNcYaKMZebIFUlACU
        35Xfb0QLLZaOMLf4xSXn/jgiREdhoBFVLEVA9uGubJIdigBjq6CmUxgqUBDXNCBMEZI+7dcZFsAAG
        dHrHGSzA==;
Received: from [10.9.9.127] (helo=rmmprod05.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKHf4-0003Vw-8K; Sat, 06 Aug 2022 13:08:06 +0200
Received: from mail by rmmprod05.runbox with local (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKHf4-0001d6-6W; Sat, 06 Aug 2022 13:08:06 +0200
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received: from [Authenticated alias (604044)] by runbox.com with http
 (RMM6); Sat, 06 Aug 2022 11:08:06 GMT
From:   "Michal Luczaj" <mhal@rbox.co>
To:     "Nadav Amit" <nadav.amit@gmail.com>
CC:     "Paolo Bonzini" <pbonzini@redhat.com>, "kvm" <kvm@vger.kernel.org>,
        "shuah" <shuah@kernel.org>,
        "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "Sean Christopherson" <seanjc@google.com>
Subject: Re: [kvm-unit-tests PATCH 2/4] x86: emulator.c cleanup: Use
 ASM_TRY for the UD_VECTOR cases
Date:   Sat, 06 Aug 2022 13:08:06 +0200 (CEST)
X-RMM-Aliasid: 604044
X-Mailer: RMM6
In-Reply-To: <CA0EBF68-648D-483F-B629-7C1B70D1E73C@gmail.com>
Message-Id: <E1oKHf4-0001d6-6W@rmmprod05.runbox>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 5 Aug 2022 19:00:12 -0700, Nadav Amit <nadav.amit@gmail.com> wrote:
> On Aug 5, 2022, at 12:59 PM, Sean Christopherson <seanjc@google.com> wrot=
e:
> > On Fri, Aug 05, 2022, Michal Luczaj wrote:
> >> On Fri, 5 Aug 2022 13:42:40 +0200, Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> >>> The original reason was to test Linux using MOVBE even on non-Atom=20
> >>> machines, when MOVBE was only on Atoms. :)
> >>=20
> >> So the emulator's logic for MOVBE is meant to be tested only when the
> >> guest supports MOVBE while the host does not?
> >=20
> > Ah, I see what you're asking.  No, it's perfectly legal to test MOVBE e=
mulation
> > on hosts that support MOVBE, i.e. using FEP is allowed.  But because KV=
M emulates
> > MOVBE on #UD and the KUT testcase is guaranteed to generate a #UD (barr=
ing a
> > hardware bug), there's no need to use FEP.  And not using FEP is advant=
ageous
> > because it avoids depending on an opt-in non-production module param.
>=20
> If history is discussed, the test was created long before FEP. Without FE=
P,
> the way to force the emulator to emulate an instruction was to set the
> instruction in memory that is not mapped to the guest. But, as Sean state=
d,
> this test always triggers #UD, so it was not necessary.
>=20
> The purpose of this test was to check a KVM fix for a bug that was found
> during fuzzing:
>=20
> https://lore.kernel.org/all/5475DC42.6000201@redhat.com/T/#m3a0da02d7c750=
c28816b08c43cf2ca03252b8bad

OK, I think I finally get it. Thank you, guys, for all the details.

Michal
