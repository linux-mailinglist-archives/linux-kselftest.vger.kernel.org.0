Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54A074A7A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjGFX1x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 19:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFX1w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 19:27:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D42139;
        Thu,  6 Jul 2023 16:27:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-262e839647eso998832a91.2;
        Thu, 06 Jul 2023 16:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688686035; x=1691278035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bshFgcOle4AtCEA8BTrEZy72fJQG+YZaemfgC6JBXtM=;
        b=IOWiwnyWZ8b/Gees9+bG/u0x39WWkdTCEFwE5s22SnFW0XqC5rvrUBYyTAMCmPKnJI
         4qgrjSpARX+HgWz9r6G2mSEL12oNVjQzOzkJqh3SzPGRq+dOdz2w69HGJqAgtWs3B+FF
         T6HW7smfo85Kiy1q9wyrh5thmF1HeIclKjwIH6EhYa02ctmARHBhKmOapagUI9oe+V7q
         uoPvVu9uynFN4Sr5hgnBSuTuO3OcHkSwGSiZFHxXBsK82s4HjycRFyZstD5Yw4wGvRYw
         1QoXQABJKLn0yVKHJ9xKaDeEnTkTKYmmzeS96+jpOAiqhUnv1SaL0yR9rZHub1JRR4EU
         /sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688686035; x=1691278035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bshFgcOle4AtCEA8BTrEZy72fJQG+YZaemfgC6JBXtM=;
        b=MHWeUiwqxpYZcakCqf3PvdRNUg2pOpaY9zc2APg1NoPf24mmi9AqGRy1VHiNAPmZtO
         ePgx1UUD7oAudjizDx0voVDY/zA5uTlRknqncr8F0THC9W8BUz08hPhUzotm+3p6sfjA
         6oCjD9cZJT+/xfKVWQdSG490UQwXs6JvpyxnScyhqJugb7MSCDs74A1iX+aYPEmPk7OJ
         HapNR2d6mGYJ4t6CnXJalznW48KQxkgYHMMWcl7dMXhlb2DXdMHFiru4jVcITms6jJYN
         Tp1ttSmGRh4sSD/EJjlgHVvOSyrXcdiFcJVqk6p6Ug6RfGVH2TS1QP13QvQsnXdEY7mb
         Z1QQ==
X-Gm-Message-State: ABy/qLZRDiZ/qHwVbRXiF0Xg8NMMjNqaRGNNxKG4NuPgm1vmYgLE57n5
        tHllK1GWlUMhiYDsPgRJH2s=
X-Google-Smtp-Source: APBJJlFvuQWESuYnnmEsR9Q/RlJxwVOHx3CZ7iqj95A72EuTZBpzNQR7aSAdAsIzLqTLdZ3dQSY+iQ==
X-Received: by 2002:a17:90a:bb84:b0:25b:e07f:4c43 with SMTP id v4-20020a17090abb8400b0025be07f4c43mr3123081pjr.10.1688686035098;
        Thu, 06 Jul 2023 16:27:15 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:400::5:9b44])
        by smtp.gmail.com with ESMTPSA id bk15-20020a17090b080f00b0025bf1ea918asm270552pjb.55.2023.07.06.16.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 16:27:14 -0700 (PDT)
Date:   Thu, 6 Jul 2023 16:27:09 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, song@kernel.org, jolsa@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@hansenpartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH 00/10] KEYS: Introduce user asymmetric keys and
 signatures
Message-ID: <20230706232709.t6imkh3q234b3dlm@macbook-pro-8.dhcp.thefacebook.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 06, 2023 at 04:42:13PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Define a new TLV-based format for keys and signatures, aiming to store and
> use in the kernel the crypto material from other unsupported formats
> (e.g. PGP).
> 
> TLV fields have been defined to fill the corresponding kernel structures
> public_key, public_key_signature and key_preparsed_payload.
> 
> Keys:
>                 struct public_key {     struct key_preparsed_payload {
> KEY_PUB       -->  void *key;
>                    u32 keylen;         --> prep->payload.data[asym_crypto]
> KEY_ALGO      -->  const char *pkey_algo;
> KEY_KID0
> KEY_KID1                               --> prep->payload.data[asym_key_ids]
> KEY_KID2  
> KEY_DESC                               --> prep->description
> 
> 
> Signatures:
>                 struct public_key_signature {
> SIG_S         -->  u8 *s;
>                    u32 s_size;
> SIG_KEY_ALGO  -->  const char *pkey_algo;
> SIG_HASH_ALGO -->  const char *hash_algo;
>                    u32 digest_size;
> SIG_ENC       -->  const char *encoding;   
> SIG_KID0
> SIG_KID1      -->  struct asymmetric_key_id *auth_ids[3];
> SIG_KID2  
> 
> 
> For keys, since the format conversion has to be done in user space, user
> space is assumed to be trusted, in this proposal. Without this assumption,
> a malicious conversion tool could make a user load to the kernel a
> different key than the one expected.
> 
> That should not be a particular problem for keys that are embedded in the
> kernel image and loaded at boot, since the conversion happens in a trusted
> environment such as the building infrastructure of the Linux distribution
> vendor.
> 
> In the other cases, such as enrolling a key through the Machine Owner Key
> (MOK) mechanism, the user is responsible to ensure that the crypto material
> carried in the original format remains the same after the conversion.
> 
> For signatures, assuming the strength of the crypto algorithms, altering
> the crypto material is simply a Denial-of-Service (DoS), as data can be
> validated only with the right signature.
> 
> 
> This patch set also offers the following contributions:
> 
> - An API similar to the PKCS#7 one, to verify the authenticity of system
>   data through user asymmetric keys and signatures
> 
> - A mechanism to store a keyring blob in the kernel image and to extract
>   and load the keys at system boot
>   
> - eBPF binding, so that data authenticity verification with user asymmetric
>   keys and signatures can be carried out also with eBPF programs

Nack to bpf bits.
You've convinced us that bpf_verify_pkcs7_signature() is what you need.
Yet, 9 month later there are no users of it and you came back with this new
bpf_verify_uasym_signature() helper that practically not much different.

Instead of brand new "public key info" format sign your rpms via
existing pkcs7 mechanism and verify with bpf_verify_pkcs7_signature().
