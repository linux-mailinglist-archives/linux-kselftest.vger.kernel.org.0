Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28D741505
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjF1PbO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 11:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjF1PbI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 11:31:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F82713
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 08:31:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so10538115e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687966265; x=1690558265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IfioyVtT4msXKVwBRY8hJRreQinRlAOTnCUWvwDS1Aw=;
        b=nry6CZib6BV+AVd9Jk+pSwezqKgJEVfCuLR1JPZqElVBafAbkTyVeLi23REdJ6UEpg
         9stYvq8YgzwEPCHN9NTab2eV+iVMOW0i1JtZckyoqUkOqAK/pllmiGFsiJyi/bGGmj0g
         uY8ae0D2A0kbhPeOit3SFGY/QpNNcJRa7uQ1BDpqgpoEJczZvtp89ssBJzKc/kawnUOB
         atCKfE7Yoaxl9aqs3r2EGFKpxM5ILitcnFo+bBsy8auSHXE+0PmyupdqfDGMEBwziN/7
         qAele+pj645BeJJh0/y4NqCqgdPy/Do3S/HEYa/GMX60Lj1lLqJlHYjmmAP0XDdGf4y/
         bZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966265; x=1690558265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfioyVtT4msXKVwBRY8hJRreQinRlAOTnCUWvwDS1Aw=;
        b=jFNPY1loGyo/ROcF679VPzqHxa7wpI+0bEAXr9UubI/PX4rHQ3NAWUJZBkwkIJHDS0
         ZY3gBz1jzFlKIdN4jvJu7Qg864RKMExUxD17VfS+T6Q40PQ5IsT70/Kh3ttX4XSdoXpn
         JmI181igpbL9EtHh27679Fpg+7nRtKqcxYPncVZK9EEnIk7pCfJD3YOPcZe/jFN8/IaS
         3xLfW2zXOjKdP9UHGqsEkWNo0nTS25nf3u78QRM0TqRl5KDqQzIEFZRtnwq6Kk6eQBG6
         JXiVCK6UY1nJe0fiIKgviN6JYxQTQIuJLfl/FCZdjdj2WpOufoiDgmhIN6lIuh/VbupW
         gLUA==
X-Gm-Message-State: ABy/qLas2HebXTmjNHwf31loR4nesPaSMIjJuVOZwypxgrCBPXywf/e8
        hP6gQDWX/EyH8otdSKOzQ9yA8Q==
X-Google-Smtp-Source: APBJJlEDnF97Eu/Q7rpDbn1H8DAMbx62dWdqkjaN8NPN/NE+nlQmuCQLftLd2qSWd/ZkLyHAStV++Q==
X-Received: by 2002:a5d:544d:0:b0:314:1096:6437 with SMTP id w13-20020a5d544d000000b0031410966437mr1329640wrv.19.1687966264829;
        Wed, 28 Jun 2023 08:31:04 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b00313f7fc35e9sm6703755wrt.63.2023.06.28.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:31:04 -0700 (PDT)
Date:   Wed, 28 Jun 2023 17:31:01 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        dhowells@redhat.com, brijesh.singh@amd.com, atishp@rivosinc.com,
        gregkh@linuxfoundation.org, linux-coco@lists.linux.dev,
        joey.gouly@arm.com
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <ZJxSNboEUbv4/4yF@vermeer>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
 <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
 <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 27, 2023 at 06:36:07PM -0700, Dionna Amalie Glaze wrote:
> On Tue, Jun 27, 2023 at 5:13 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > [..]
> > >
> > > The VMPL-based separation that will house the supervisor module known
> > > as SVSM can have protocols that implement a TPM command interface, or
> > > an RTMR-extension interface, and will also need to have an
> > > SVSM-specific protocol attestation report format to keep the secure
> > > chain of custody apparent. We'd have different formats and protocols
> > > in the kernel, at least, to speak to each technology.
> >
> > That's where I hope the line can be drawn, i.e. that all of this vendor
> > differentiation really only matters inside the kernel in the end.
> >
> > > I'm not sure it's worth the trouble of papering over all the... 3-4
> > > technologies with similar but still weirdly different formats and ways
> > > of doing things with an abstracted attestation ABI, especially since
> > > the output all has to be interpreted in an architecture-specific way
> > > anyway.
> >
> > This is where I need help. Can you identify where the following
> > assertion falls over:
> >
> > "The minimum viable key-server is one that can generically validate a
> > blob with an ECDSA signature".
> >
> > I.e. the fact that SEV and TDX send different length blobs is less
> > important than validating that signature.
> >
> > If it is always the case that specific fields in the blob need to be
> > decoded then yes, that weakens the assertion. However, maybe that means
> > that kernel code parses the blob and conveys that parsed info along with
> > vendor attestation payload all signed by a Linux key. I.e. still allow
> > for a unified output format + signed vendor blob and provide a path to
> > keep all the vendor specific handling internal to the kernel.
> >
> 
> All the specific fields of the blob have to be decoded and subjected
> to an acceptance policy. That policy will most always be different
> across different platforms and VM owners. I wrote all of
> github.com/google/go-sev-guest, including the verification and
> validation logic, and it's going to get more complicated, and the
> sources of the data that provide validators with notions of what
> values can be trusted will be varied. The formats are not
> standardized. The Confidential Computing Consortium should be working
> toward that, but it's a slow process. There's IETF RATS. There's
> in-toto.io attestations. There's Azure's JWT thing. There's a signed
> serialized protocol buffer that I've decided is what Google is going
> to produce while we figure out all the "right" formats to use. There
> will be factions and absolute gridlock for multiple years if we
> require solidifying an abstraction for the kernel to manage all this
> logic before passing a report on to user space.

I agree with most of the above, but all that nightmate^Wcomplexity is
handled on the remote attestation side. If I understand the current
discussion, it's about how to abstract a guest attestation evidence
generation request in a vendor agnostic way. And I think what's proposed
here is simply to pass a binary payload (The evidence request from the
guest userspace) to the kernel key subsystem, hook it into vendor
specific handler and get userspace an attestation evidence (a platform
key signed blob) back to the guest app. The guest app can then give that
to an attestation service, and that's when all the above described
complexity takes place. Am I missing something?

> Now, not only are the field contents important, the certificates of
> the keys that signed the report are important. Each platform has its
> own special x509v3 extensions and key hierarchy to express what parts
> of the report should be what value if signed by this key, and in TDX's
> case there are extra endpoints that you need to query to determine if
> there's an active CVE on the associated TCB version. This is how they
> avoid adding every cpu's key to the leaf certificate's CRL.
> 
> You really shouldn't be putting attestation validation logic in the
> kernel. 

AFAIU, that's not part of the proposal/PoC/mockup. It's all about
funneling an attestation evidence request down to the TSM/PSP/firmware
for it to generate an actually verifiable attestation evidence.

Cheers,
Samuel.
