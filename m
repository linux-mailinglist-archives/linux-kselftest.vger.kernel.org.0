Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078B7852B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjHWIcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjHWI2d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 04:28:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82381737;
        Wed, 23 Aug 2023 01:25:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692779123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YABGz93CwcKXya0myrUbxzMc6GMWWiFYKpVWpDX9Jqg=;
        b=L4GoeeBRl3glZv6lbixeTgYrBZpSrPDFsQdLhJawqekTDt5YAaSikOYK2DPF3KB0+Hbfr1
        nUiOjO6Zk9a/Q+yhHwGSPzgpFSYuS8fPk7cuDkI9ywShgWhbWl8V0Rf4h4sej0Zn2QEP5v
        N8dRldK3jc1LZLrahFjJQrgnNJ51AkJ7LRUF+1NZcnbdlG5DnT3tOdEqtb5yyMuXJEdPPe
        jV+/JE1r1Gsilt1LJRMIcoAHf2uOvwIzLrHk0zQja4OtfCJsgw9aheTasZPyJ4pElokhc6
        r/8Tg6H2Os3mA40bXhnm/2v0+NDrCVRExgjAZlEyEDpdbbV+Q6/ff8hGhBsK2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692779123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YABGz93CwcKXya0myrUbxzMc6GMWWiFYKpVWpDX9Jqg=;
        b=ZpBuholq/wvCUXcRLF6xZLyx25TNsMb5dhHgBFxho60PTxz6hV1vXqbhkVWnORuyBBJJ8U
        BwimVeB9amrXjKAA==
To:     Erdem Aktas <erdemaktas@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        dhowells@redhat.com, brijesh.singh@amd.com, atishp@rivosinc.com
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
In-Reply-To: <CAAYXXYyK4g9k7a78CU9w6Sn9KTBdoNLOu9gcgrSHJfp+3-tO=w@mail.gmail.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAYXXYyK4g9k7a78CU9w6Sn9KTBdoNLOu9gcgrSHJfp+3-tO=w@mail.gmail.com>
Date:   Wed, 23 Aug 2023 10:25:22 +0200
Message-ID: <87msyidv2l.ffs@tglx>
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

On Thu, Jun 22 2023 at 14:01, Erdem Aktas wrote:
> On Mon, Jun 12, 2023 at 12:03=E2=80=AFPM Dan Williams <dan.j.williams@int=
el.com>
> wrote:
>> Now multiple
>> confidential computing vendors trying to develop similar flows with
>> differentiated formats where that differentiation need not leak over the
>> ABI boundary.
>>
>
> <Just my personal opinion below>
> I agree with this statement in the high level but it is also somehow
> surprising for me after all the discussion happened around this topic.
> Honestly, I feel like there are multiple versions of "Intel"  working in
> different directions.
>
> If we want multiple vendors trying to do the similar things behind a comm=
on
> ABI, it should start with the spec. Since this comment is coming from
> Intel, I wonder if there is any plan to combine the GHCB and GHCI
> interfaces under common ABI in the future or why it did not even happen in
> the first place.

You are conflating things here.

The GETQUOTE TDVMCALL interface is part of the Guest-Hypervisor
Communication Interface (GHCI), which is a firmware interface.

Firmware (likewise hardware) interfaces have the unfortunate property
that they are mostly cast in stone.

But that has absolutely nothing to do with the way how the kernel
implements support for them. If we'd follow your reasoning then we'd
have a gazillion of vendor specific SCSI stacks in the kernel.

> What I see is that Intel has GETQUOTE TDVMCALL interface in its spec and
> again Intel does not really want to provide support for it in linux. It
> feels really frustrating.

Intel definitely wants to provide support for this interface and this
very thread is about that support. But Intel is not in a position to
define what the kernel community has to accept or not, neither is
Google.

Sure, it would have been more efficient to come up with a better
interface earlier, but that's neither an Intel nor a TDX specific
problem.

It's just how kernel development works. Some ideas look good on first
sight, some stuff slips through and at some point the maintainers
realize that this is not the way to go and request a proper generalized
and maintainable implementation.

If you can provide compelling technical reasons why the IOCTL is the
better and more maintainable approach for the kernel, then we are all
ears and happy to debate that on the technical level.

Feel free to be frustrated, but I can assure you that the only way to
resolve this dilemma is to sit down and actually get work done in a way
which is acceptable by the kernel community at the technical level.

Everything else is frustrating for everyone involved, not only you.

Thanks,

        tglx


