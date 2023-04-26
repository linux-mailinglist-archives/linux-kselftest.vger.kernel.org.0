Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C46EF391
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbjDZLo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZLo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 07:44:58 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34304C3F;
        Wed, 26 Apr 2023 04:44:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q5xcg6yW2z9v7H0;
        Wed, 26 Apr 2023 19:35:15 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDXQOyNDklkVnlZAg--.7127S2;
        Wed, 26 Apr 2023 12:44:27 +0100 (CET)
Message-ID: <ade93f7324c5f07511a0793f702024d41889636d.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 4/6] bpf: Introduce bpf_verify_umd_signature() kfunc
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Yonghong Song <yhs@meta.com>, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mykolal@fb.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 26 Apr 2023 13:44:09 +0200
In-Reply-To: <23649e1d-8fee-079a-21de-87f7024add81@meta.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
         <20230425173557.724688-5-roberto.sassu@huaweicloud.com>
         <23649e1d-8fee-079a-21de-87f7024add81@meta.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDXQOyNDklkVnlZAg--.7127S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr48Gr1Utw4kWF4UJry8Grg_yoWrZw15pF
        W8KF4F9ry8JF1xtFyUXa13Za4Skws2qw17G3sFya4fGFnavr1fCw18tF45W3sYk348trZ5
        ZrW0q34a93W5GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
        CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBF1jj4yCiQABsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2023-04-25 at 14:25 -0700, Yonghong Song wrote:
> 
> On 4/25/23 10:35 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Introduce the bpf_verify_umd_signature() kfunc, to verify UMD-parsed
> > signatures. The parameters and usage are the same as for
> > bpf_verify_pkcs7_signature().
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   kernel/trace/bpf_trace.c | 69 ++++++++++++++++++++++++++++++++--------
> >   1 file changed, 55 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index e8da032bb6f..c9cae337596 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1271,7 +1271,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
> >    * The key pointer is marked as invalid, to prevent bpf_key_put() from
> >    * attempting to decrement the key reference count on that pointer. The key
> >    * pointer set in such way is currently understood only by
> > - * verify_pkcs7_signature().
> > + * verify_pkcs7_signature() and verify_umd_signature().
> >    *
> >    * Set *id* to one of the values defined in include/linux/verification.h:
> >    * 0 for the primary keyring (immutable keyring of system keys);
> > @@ -1317,6 +1317,27 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
> >   }
> >   
> >   #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > +static int validate_key(struct bpf_key *trusted_keyring)
> > +{
> > +	int ret = 0;
> > +
> > +	if (trusted_keyring->has_ref) {
> > +		/*
> > +		 * Do the permission check deferred in bpf_lookup_user_key().
> > +		 * See bpf_lookup_user_key() for more details.
> > +		 *
> > +		 * A call to key_task_permission() here would be redundant, as
> > +		 * it is already done by keyring_search() called by
> > +		 * find_asymmetric_key().
> > +		 */
> > +		ret = key_validate(trusted_keyring->key);
> > +		if (ret < 0)
> > +			return ret;
> 
> The above
> 	if (ret < 0)
> 		return ret;
> can be removed.

Right, thanks!

Roberto

> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >   /**
> >    * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> >    * @data_ptr: data to verify
> > @@ -1334,19 +1355,9 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
> >   {
> >   	int ret;
> >   
> > -	if (trusted_keyring->has_ref) {
> > -		/*
> > -		 * Do the permission check deferred in bpf_lookup_user_key().
> > -		 * See bpf_lookup_user_key() for more details.
> > -		 *
> > -		 * A call to key_task_permission() here would be redundant, as
> > -		 * it is already done by keyring_search() called by
> > -		 * find_asymmetric_key().
> > -		 */
> > -		ret = key_validate(trusted_keyring->key);
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > +	ret = validate_key(trusted_keyring);
> > +	if (ret < 0)
> > +		return ret;
> >   
> >   	return verify_pkcs7_signature(data_ptr->data,
> >   				      bpf_dynptr_get_size(data_ptr),
> > @@ -1356,6 +1367,35 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
> >   				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
> >   				      NULL);
> >   }
> > +
> > +/**
> > + * bpf_verify_umd_signature - Verify a UMD-parsed signature
> > + * @data_ptr: Data to verify
> > + * @sig_ptr: Signature of the data
> > + * @trusted_keyring: Keyring with keys trusted for signature verification
> > + *
> > + * Verify the UMD-parsed signature *sig_ptr* against the supplied *data_ptr*
> > + * with keys in a keyring referenced by *trusted_keyring*.
> > + *
> > + * Return: 0 on success, a negative value on error.
> > + */
> > +__bpf_kfunc int bpf_verify_umd_signature(struct bpf_dynptr_kern *data_ptr,
> > +					 struct bpf_dynptr_kern *sig_ptr,
> > +					 struct bpf_key *trusted_keyring)
> > +{
> > +	int ret;
> > +
> > +	ret = validate_key(trusted_keyring);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return verify_umd_signature(data_ptr->data,
> > +				    bpf_dynptr_get_size(data_ptr),
> > +				    sig_ptr->data, bpf_dynptr_get_size(sig_ptr),
> > +				    trusted_keyring->key,
> > +				    VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
> > +				    NULL);
> > +}
> >   #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> >   
> >   __diag_pop();
> > @@ -1366,6 +1406,7 @@ BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
> >   BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
> >   #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> >   BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_verify_umd_signature, KF_SLEEPABLE)
> >   #endif
> >   BTF_SET8_END(key_sig_kfunc_set)
> >   

