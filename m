Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD858785195
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjHWHdM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 03:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjHWHdL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 03:33:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11525128;
        Wed, 23 Aug 2023 00:33:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692775988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/S8aAMC8431wDl9EHieHaDMQtPnYNA9A+BMaoDCWW+Y=;
        b=p3b//x87LF4MIS/ydL5RQPDyLPAa3wrJ8ZuI1YF5NmpSVzakWWcYXUcNiAmulCkgSMuHfl
        pBcVXeoFemeMmwv+M+gjYtmZIRggmYr8+3Uub9vjYchbDMXHVderVZWyLbdxL711mzcHoD
        qLvzmoOnjs3lBLquIAEbSJChuFqOMgF9Wde2tPcNAOJ/riVPcq/Fwg66kWVfH9xP854OuZ
        QOVRnX0HAXS5yQiti8MJ+LoFLGW3XKk1huGDQCjGVwy3QBUkxR4ygYoLPx9YTGXOonPwUk
        ivHnhdLU8R8QHpz5oMuk2wpw6QFY7JgqOuC3hvWenp5hKbgonNnwngLeadrJjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692775988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/S8aAMC8431wDl9EHieHaDMQtPnYNA9A+BMaoDCWW+Y=;
        b=Sm4+LbiyXoHegImmukuqOtU0ct8r9zucugT0HQj8DWGSLsSpC2ALLcb8vFcgdmq4TAspsd
        iWBQPT58aDXQGXBQ==
To:     Chong Cai <chongc@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] TDX Guest Quote generation support
In-Reply-To: <CALRH0CiHjNeaHS88Oa_57hS_WGXY3-x2_aHco14nQpo-5e9seA@mail.gmail.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64966b842becf_142af8294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <cdd04046-4bcb-d6fd-1688-0a85546e7b91@linux.intel.com>
 <649914ab3de4d_8e17829490@dwillia2-xfh.jf.intel.com.notmuch>
 <CALRH0CiHjNeaHS88Oa_57hS_WGXY3-x2_aHco14nQpo-5e9seA@mail.gmail.com>
Date:   Wed, 23 Aug 2023 09:33:07 +0200
Message-ID: <87pm3edxho.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 27 2023 at 00:50, Chong Cai wrote:
> On Sun, Jun 25, 2023 at 9:32=E2=80=AFPM Dan Williams <dan.j.williams@inte=
l.com> wrote:
>> What I would ask of those who absolutely cannot support the TDVMCALL
>> method is to contribute a solution that intercepts the "upcall" to the
>> platform "guest_attest_ops" and turn it into a typical keys upcall to
>> userspace that can use the report data with a vsock tunnel.
>>
>> That way the end result is still the same, a key established with the
>> TDX Quote evidence contained within a Linux-defined envelope.
>
> I agree a unified ABI across vendors would be ideal in the long term.
> However, it sounds like a non-trivial task and could take quite some
> time to achieve.
> Given there's already an AMD equivalent approach upstreamed, can we
> also allow this TDVMCALL patch as an intermediate step to unblock
> various TDX attestation user cases while targeting unified ABI? The
> TDVMCALL here is quite isolated and serves a very specific purpose, it
> should be very low risk to other kernel features and easy to be
> reverted in the future.

No way. This is exactly how the kernel ends up with an unmaintainable
mess simply because this creates an user space ABI which is not
revertable ever.

It's bad enough that nobody paid attention when the AMD muck was merged,
but that does not make an argument or any form of justification to add
more of this.

Dan's proposal makes a lot of sense and allows to implement this in a
mostly vendor agnostic way. While the AMD interface is not going away
due to that, I'm 100% confident (pun intended) that such an unified
interface is going to be utilized and supported by AMD (or any other
vendor) sooner than later simply because the user space people who have
to implement vendor agnostic orchestration tools will go for it as it
makes their life easier too.

The time wasted to argue about this TDX ioctl mess could have been spent
to actually migrate TDX over to this scheme. But sure it's way simpler
to flog a dead horse instead of actually sitting down and getting useful
work done.

Thanks,

        tglx
