Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F393054E99C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiFPSo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiFPSo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 14:44:58 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AFA2C132;
        Thu, 16 Jun 2022 11:44:56 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655405094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vyq1QaJNcPGeZXUPChWIIfLLby0vd/A5lJq5m22MfDI=;
        b=F77myjhPBWu0h7ouFKKj0XC9PilN0M7a9ouW2YaFoSXdgN8CVJ+CDau2RV6XCwtnnBluRB
        ayIgk0cX5PRFYRmiToLFeK4mXWHDK2B5vHwt7UBftBK/BrEqJCGKICgjanti1ZbxByX7Lp
        ULHroYgZFgfrGwnb1buKFIR5ktUxAfo=
Date:   Thu, 16 Jun 2022 18:44:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   oliver.upton@linux.dev
Message-ID: <7b1040c48bc9b2986798322c336660ab@linux.dev>
Subject: Re: [PATCH] selftests: KVM: Handle compiler optimizations in
 ucall
To:     "David Laight" <David.Laight@aculab.com>
Cc:     "Raghavendra Rao Ananta" <rananta@google.com>,
        "Marc Zyngier" <maz@kernel.org>,
        "James Morse" <james.morse@arm.com>,
        "Alexandru Elisei" <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Peter Shier" <pshier@google.com>,
        "Ricardo Koller" <ricarkol@google.com>,
        "Oliver Upton" <oupton@google.com>,
        "Reiji Watanabe" <reijiw@google.com>,
        "Jing Zhang" <jingzhangos@google.com>,
        "Colton Lewis" <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "Andrew Jones" <drjones@redhat.com>
In-Reply-To: <3e73cb07968d4c92b797781b037c2d45@AcuMS.aculab.com>
References: <3e73cb07968d4c92b797781b037c2d45@AcuMS.aculab.com>
 <20220615185706.1099208-1-rananta@google.com>
 <20220616120232.ctkekviusrozqpru@gator>
 <33ca91aeb5254831a88e187ff8d9a2c2@AcuMS.aculab.com>
 <20220616162557.55bopzfa6glusuh5@gator>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

June 16, 2022 11:48 AM, "David Laight" <David.Laight@aculab.com> wrote:=
=0A> No wonder I was confused.=0A> It's not surprising the compiler optim=
ises it all away.=0A> =0A> It doesn't seem right to be 'abusing' WRITE_ON=
CE() here.=0A> Just adding barrier() should be enough and much more descr=
iptive.=0A=0AI had the same thought, although I do not believe barrier() =
is sufficient=0Aon its own. barrier_data() with a pointer to uc passed th=
rough=0Ais required to keep clang from eliminating the dead store.=0A=0A-=
-=0AThanks,=0AOliver
