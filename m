Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE9F74AB84
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 09:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjGGHEW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 03:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjGGHEQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 03:04:16 -0400
Received: from frasgout11.his.huawei.com (ecs-14-137-139-23.compute.hwclouds-dns.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269401709;
        Fri,  7 Jul 2023 00:04:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qy3xy4Zzrz9xqdN;
        Fri,  7 Jul 2023 14:53:10 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHrumsuKdkc9w3BA--.59443S2;
        Fri, 07 Jul 2023 08:03:29 +0100 (CET)
Message-ID: <46a2328ab35907970dcd9a7240cd9072abeb66b2.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 00/10] KEYS: Introduce user asymmetric keys and
 signatures
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Date:   Fri, 07 Jul 2023 09:03:05 +0200
In-Reply-To: <20230706232709.t6imkh3q234b3dlm@macbook-pro-8.dhcp.thefacebook.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
         <20230706232709.t6imkh3q234b3dlm@macbook-pro-8.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBHrumsuKdkc9w3BA--.59443S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArW5Jr48KFWrWw43tw17Awb_yoW5ZFWrpF
        WrKayrArykJwnxJa4ktw40gayft3y8J3W3KwnxKrWrCwn0gryayr4xKF4rur9akr1kWr10
        vrZ5A343Gwn5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj4-hwgAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-07-06 at 16:27 -0700, Alexei Starovoitov wrote:
> On Thu, Jul 06, 2023 at 04:42:13PM +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Define a new TLV-based format for keys and signatures, aiming to store and
> > use in the kernel the crypto material from other unsupported formats
> > (e.g. PGP).
> > 
> > TLV fields have been defined to fill the corresponding kernel structures
> > public_key, public_key_signature and key_preparsed_payload.
> > 
> > Keys:
> >                 struct public_key {     struct key_preparsed_payload {
> > KEY_PUB       -->  void *key;
> >                    u32 keylen;         --> prep->payload.data[asym_crypto]
> > KEY_ALGO      -->  const char *pkey_algo;
> > KEY_KID0
> > KEY_KID1                               --> prep->payload.data[asym_key_ids]
> > KEY_KID2  
> > KEY_DESC                               --> prep->description
> > 
> > 
> > Signatures:
> >                 struct public_key_signature {
> > SIG_S         -->  u8 *s;
> >                    u32 s_size;
> > SIG_KEY_ALGO  -->  const char *pkey_algo;
> > SIG_HASH_ALGO -->  const char *hash_algo;
> >                    u32 digest_size;
> > SIG_ENC       -->  const char *encoding;   
> > SIG_KID0
> > SIG_KID1      -->  struct asymmetric_key_id *auth_ids[3];
> > SIG_KID2  
> > 
> > 
> > For keys, since the format conversion has to be done in user space, user
> > space is assumed to be trusted, in this proposal. Without this assumption,
> > a malicious conversion tool could make a user load to the kernel a
> > different key than the one expected.
> > 
> > That should not be a particular problem for keys that are embedded in the
> > kernel image and loaded at boot, since the conversion happens in a trusted
> > environment such as the building infrastructure of the Linux distribution
> > vendor.
> > 
> > In the other cases, such as enrolling a key through the Machine Owner Key
> > (MOK) mechanism, the user is responsible to ensure that the crypto material
> > carried in the original format remains the same after the conversion.
> > 
> > For signatures, assuming the strength of the crypto algorithms, altering
> > the crypto material is simply a Denial-of-Service (DoS), as data can be
> > validated only with the right signature.
> > 
> > 
> > This patch set also offers the following contributions:
> > 
> > - An API similar to the PKCS#7 one, to verify the authenticity of system
> >   data through user asymmetric keys and signatures
> > 
> > - A mechanism to store a keyring blob in the kernel image and to extract
> >   and load the keys at system boot
> >   
> > - eBPF binding, so that data authenticity verification with user asymmetric
> >   keys and signatures can be carried out also with eBPF programs
> 
> Nack to bpf bits.

Sure, no problem. Will remove them in the next iteration.

> You've convinced us that bpf_verify_pkcs7_signature() is what you need.
> Yet, 9 month later there are no users of it and you came back with this new
> bpf_verify_uasym_signature() helper that practically not much different.
> 
> Instead of brand new "public key info" format sign your rpms via
> existing pkcs7 mechanism and verify with bpf_verify_pkcs7_signature().

Asking Linux distribution vendors to execute gpg in their kernel build,
or asking them to revisit their PKI, rebuild all their packages, and
adapting all their tools dealing with the current mechanism?

Which solution do you think it is better?

Thanks

Roberto

