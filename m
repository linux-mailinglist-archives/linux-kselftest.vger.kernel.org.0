Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C905648737
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLIRFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Dec 2022 12:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLIREe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Dec 2022 12:04:34 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A58178AE
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Dec 2022 09:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670605378; bh=MyMUlj5UJfAp+eU10kjTGA4h5Trvl3n2yx62dVmJUto=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jgF8+VlCs6Y6af9d+SoUZk4sjlHmAMM9jatMFidCPMpakgmpdJAp0KaHYiuZs3gJXM6FxYRql01CnvNKogqU+yKcLWKM3kY/i68pxEGkOrz6RLm0AyDceyoBVbafyBtkum9uvB4ijj059yK5obUDr+0dASpWusgYUOZUMQaHUGDbqZycdgQKK0mnZoOP2DH/EzAgS2HAp8Ld9ehe6UmuDdnRcULifBPbiSpijski+a4GWur6VhdriBo7f1UWlPuZR2RM/GVdM1l4b1cR75CFLvO92riOHvdtJPIpoAXO4LmqIEaTrIdgnPARIDt/o4MeQW1KUjj5GsOFUNNT08fjmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670605378; bh=GTyIwEIyFc5nHqUqmDYhYYe5Y/368xxilQ4FUXbpB89=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tgIHUMJPlmRBTH8YWeM3Zlrd4CKTireMXVbpHoq6kJfsk+u7QZUZ0RnXLrc9C0jyX0mNtqDXwNUb/xZGnB6NzD5fLdD8n2DEWA8hDloKdob+A7lgjAIt2oCMg7VW554Ud9Qs1qnqhg4c8UX/iRWm1n0obB92UXDcfUAxf0xRfKB8YEKSbFAM9zLjJ/EZlsGRx1PhZF9wwJH9/DtE0K+k6IprJI8JFAUjZ9+lWDMJ4+DLZSB68oYYCALIIB8NM+ezaOkQLgCufIBCxr/jkOdgj87CtmRBv4LLPre01/eQeoZw9+fC90t6AZ0q9PPKI1yRWgV44vOrYiC5JiP2+3pVPg==
X-YMail-OSG: lL7Y9y8VM1l_BqUfrYBN0lBOjEdhHbVchVr58QRsi3aIdTLukr5phEZ89VFvAVB
 CkJZVQotERsst7pKJTRrunU5CoMB9K2f2B8kCohnOkNNefFwVMUsyueCpkW9QTcdG3LU3EXbfsuU
 TiG5g2zbDzcS2R7sWX5lpjpkX.u__XO.HzCEYKG41gfLpoenWmauCarpfnFXxgS2pQecjBwCO6PD
 ynhjahxMhud5vJs2OoYrNufdZSvpBSzn9kqXHJJgrvDGnT7V.L9jpIZ9Xgf1uHBD9R4216xXgSIt
 kCBougzYXFtfHMc_qRLa1E1gNJ23XDr.Lvt1hLEG2R5YSAGCdbMYipe3vhJpcXUDcm5rEby7AKm8
 YbShrXjXEye0MRbeqdYDNfib46KRlhYnjazTZBtkfqAqQ4ykyoyT1ybMlIUuXxevMuJQsXkBIWvV
 Mk6PGVuviyztEUOr.k1kZyAQMp3_vewfh.S2ZTk4XD0EJjWbt0GBt4BIPCRtV_Wd5d8Z3mVOvgXr
 eE1tzxgjZRx.G0iCJ0hRVUfZ9vh2TjcdcqodgWMhH0R3JxXYBGnEEuC1PTDcgtNU_iJ6Q2IPBYht
 LnHisQ5Yibsrrd24thyCKcTOuGM0iAe5zIYVtvL68YXzjwidxjkmvWOc4hII8xSOEeQ8oU8LXosZ
 ZlZQzW_t_mCLx6KMVs0FDM0MTcpB_G1Ay5Ifu.vdx.hBhu8eyJ0Hrqp8NizEHkbJziYdG1TCtwF7
 bpmVWlVHEF8JVPtgxbpJ0X.fCbenpmPwCJ9QHqM2iBGu9IftV_wAdSP5STjMP9KsH5C_cZDD5Plq
 yqaW27p4Q.OhNDfuKZgI.k76WvS2wCCxgJvIz7O1Pl9OPhis4HuVcaJsDUCW8kxu9Vq3SFyQF2nT
 IdQSiCKXi8Io66Yj8.AyadVeTdS.oe1A9v0RN68LldyfiU2AoI3b_yYB77R8lQzBA9hLxSHk0PkI
 dIPCZEonwyYYaCkuS04TaOUHwluvs8oFCzR5kCEhquIQ_DBwR_LZL.SAwM6PKN_tf.Q17pd3oPQe
 C961a.CIol4JkGkxS8FRW6SwhD7QNfjNeI50F10jBL9CopYj4Uot1t_WbeSYoS30_U6QZ3ghNvup
 vwxqywDrpiEJWFf.vrrYy2cprtCb6D1JfqTZ53xYMz_OYC19yGe5JePPttXsii_f1FkZMLJKl2La
 TPmnfJ_Zv41uAqKuz1EA3vm4wEB1kn_gBLFLj3WILqzY9SRW4m.R025Fwvf7CIvb3PxqfuiZ5yNG
 tIOHctNTq3DkfltRNsbX5g6gRkk0fOANOkwKS6V.BVU8QLWVg8FSXNL.O7i91POcuF10w5ZG86Se
 SeARFe.mzj6GxVlkOcrJZdwHgF11a853lTc_xs.zT6VbhDZ7fXBM6ftvPni6ni.9NarO2dHJHDpa
 _PzYAZWWPVYO.Zx9mAyE_ApDkl749_1GPJlhbCNRoZ6krhuagsLyjk8DbLCIw17quxpAh_KIVjXJ
 TEhNVWvtE7Ldkpq2FqAMV595IcJcvr9BRpdkEw251uBMRuXuJqugNK_yAqBqrohidzNDEh21WhhE
 PuKMyC7bPiSGML__cCIStn.9nBJpnEjLhTJurMDu3T1mVjvtXf5Z.0Bufsic1393kL51QVqnkhhi
 VebC1XJwhlNhjodPBZcdlxbAeCJT6kG3zaWdEDFccO50MHxq9mv7EPKH_hjeKSFTiL91YDpJx1CU
 XR9zYqJ46kVPrKMQdcipTwrg7.ppIu4YuBEtzpuShZS0N_crtiZkK4K6jU.pjbP95dTrQCj_FCsu
 1KzvlJYgDU7UULTFo6t8dIqqGlJqIZE8zslrCCYIo2E1DABEtLhRrpehZ0pT1So5Mtj95w5oc17M
 YZQenTO3eg7IK2mgg5Hcf0KtxbJIR.RwXSJpliWoaZc_6DHcoaXuh9ihYlxqcyIsMWYVjL24fI6q
 izeL6Chszszn6f1M7NGQktXNGqTORYqVwhPyw5xuq5HmL9O9rbdKYan6.2KI9O8E59sxrYVFG04b
 3QofzocQOgp2EXkywjQDZONavNapKRXjzMvJ.ESyKsNG_971A6XeRXXwJHSOWHB6FjkYjqbgXUPz
 Wzis6US_tXsCzRDPfjqeb7KB4r1PtTPQzbZte6fZh7OrIyZM2xCBO1SM_9vOBxyCgvKfKDc7cpgn
 TG01NA9Az33gUBSphK7T3x2AAzl1cY60UC6km5zTNE.aZ_VVvP_z.3LCC5DyLdwR69K7QNbjhX77
 9n4vuK6xlnRmNR9UqVFDtyh8.NQ_3pQc7Z79bZZSJL1R4nmZzg.naOf3y8ZYnn1vWcZnOctzvkY9
 g860vf6TkMbp4200-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Dec 2022 17:02:58 +0000
Received: by hermes--production-gq1-d898c4779-kw4j9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a6a3eaab463986d72460c801a21e852f;
          Fri, 09 Dec 2022 17:02:52 +0000 (UTC)
Message-ID: <27c63309-4a36-74d5-42e0-d4a2e9e02db4@schaufler-ca.com>
Date:   Fri, 9 Dec 2022 09:02:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
Content-Language: en-US
To:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>, casey@schaufler-ca.com
References: <20221209160453.3246150-1-jeffxu@google.com>
 <20221209160453.3246150-7-jeffxu@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221209160453.3246150-7-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20926 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/9/2022 8:04 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> The new security_memfd_create allows lsm to check flags of
> memfd_create.
>
> The security by default system (such as chromeos) can use this
> to implement system wide lsm to allow only non-executable memfd
> being created.
>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/lsm_hooks.h     | 4 ++++
>  include/linux/security.h      | 6 ++++++
>  mm/memfd.c                    | 5 +++++
>  security/security.c           | 5 +++++
>  5 files changed, 21 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ec119da1d89b..fd40840927c8 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> +LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
>  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
>  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
>  	 unsigned long prot, unsigned long flags)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..5a18a6552278 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -543,6 +543,10 @@
>   *	simple integer value.  When @arg represents a user space pointer, it
>   *	should never be used by the security module.
>   *	Return 0 if permission is granted.
> + * @memfd_create:
> + *	@name is the name of memfd file.
> + *	@flags is the flags used in memfd_create.
> + *	Return 0 if permission is granted.
>   * @mmap_addr :
>   *	Check permissions for a mmap operation at @addr.
>   *	@addr contains virtual address that will be used for the operation.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ca1b7109c0db..5b87a780822a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int security_memfd_create(char *name, unsigned int flags);
>  int security_mmap_file(struct file *file, unsigned long prot,
>  			unsigned long flags);
>  int security_mmap_addr(unsigned long addr);
> @@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
>  	return 0;
>  }
>  
> +static inline int security_memfd_create(char *name, unsigned int flags)
> +{
> +	return 0;
> +}
> +

Add a proper kernel doc comment for this function.

>  static inline int security_mmap_file(struct file *file, unsigned long prot,
>  				     unsigned long flags)
>  {
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 92f0a5765f7c..f04ed5f0474f 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -356,6 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
>  		goto err_name;
>  	}
>  
> +	/* security hook for memfd_create */
> +	error = security_memfd_create(name, flags);
> +	if (error)
> +		return error;
> +
>  	if (flags & MFD_HUGETLB) {
>  		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
>  					HUGETLB_ANONHUGE_INODE,
> diff --git a/security/security.c b/security/security.c
> index 79d82cb6e469..57788cf94075 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1010,6 +1010,11 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  }
>  EXPORT_SYMBOL(security_sb_clone_mnt_opts);
>  
> +int security_memfd_create(char *name, unsigned int flags)
> +{
> +	return call_int_hook(memfd_create, 0, name, flags);
> +}
> +
>  int security_move_mount(const struct path *from_path, const struct path *to_path)
>  {
>  	return call_int_hook(move_mount, 0, from_path, to_path);
