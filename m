Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB163B2C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 21:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiK1UKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 15:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiK1UKp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 15:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBBD23156
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669666195;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sF220u/GkyApiKYoqCxqyjsl0v/0IP+GvFHvvXQNpo=;
        b=BbNtEsx5oDB6cwtH4Y+H5FO2z4Zmbv+w/+Y9Jpm0ral5oqYkXKDqK2vy7SXS6rFhpfcHAE
        cfk2aUeVeu+Kwsa12AC+hGSo6NPxHcZ1umZBeZ/otRd3raaG0ZkGXo06tMdxhq31rhS8XJ
        mYEUQY61JjHojerwgROSR8P+RaFxRwY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-4-H8Z0AWOB63V8Uk_YNOyQ-1; Mon, 28 Nov 2022 15:09:52 -0500
X-MC-Unique: 4-H8Z0AWOB63V8Uk_YNOyQ-1
Received: by mail-qk1-f200.google.com with SMTP id az31-20020a05620a171f00b006fa2cc1b0bfso22811068qkb.23
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 12:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sF220u/GkyApiKYoqCxqyjsl0v/0IP+GvFHvvXQNpo=;
        b=Nb/pwBEWW8pXHMepjKXkbvv3MYl8njuzKyShtNH3Ojpvrkp1YIB+nmog6p3z/srxUU
         tCKsZQupU2bQjq30yguaSmcjTnyrGt2UgoP/gwC38aUED1KQ6HrYYe6JO4CRTvk5wVdn
         kjKMweD6PV5vXmUJ4Tg3duYARZjx1a+54pUSLgddD57fQvUcldm3d8R/bpBFEA1n3GO+
         eIKL6VF7HJhGXCenYEhrC4mta3dAwpvC41LU08uk99UULNL+1lCfYv1Oif7g3OvBr8/q
         VMIRAmTkd7wVi4hFABaBauEu7I2jkXE0qX+FcSqPzJw4BSmxR/sP3mlsWcVgbZMiLNrf
         ZSjw==
X-Gm-Message-State: ANoB5pmwse2lGYpzustKZ8XJP0f6SQDNdSIeSlmipQxSg8EOaC0Oq3J/
        X06t5h78c7tqE15Bgv3HuM+6Ro9s+n9eiz9CeEwsPc+6Zk54DlBPheLr7sy48SSzfi/Lz+d/f7a
        qHJEH5wwR4B1puv5tzOV3Ob1sMVNE
X-Received: by 2002:a05:622a:1f97:b0:3a6:39c4:dc6 with SMTP id cb23-20020a05622a1f9700b003a639c40dc6mr41636341qtb.515.1669666186706;
        Mon, 28 Nov 2022 12:09:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7WtjBWnjX0FjlsU8UH/MTtCvhMvsduqeQ0qoYF/zgpc5CFEHGvVu63Ai3dEq+pdE2AWlQz5w==
X-Received: by 2002:a05:622a:1f97:b0:3a6:39c4:dc6 with SMTP id cb23-20020a05622a1f9700b003a639c40dc6mr41636300qtb.515.1669666186370;
        Mon, 28 Nov 2022 12:09:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id r5-20020ac867c5000000b003a56796a764sm7398874qtp.25.2022.11.28.12.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 12:09:45 -0800 (PST)
Message-ID: <18b8f84b-170c-a353-f8cb-e8021f31db02@redhat.com>
Date:   Mon, 28 Nov 2022 21:09:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 11/19] iommufd: IOCTLs for the io_pagetable
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <11-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <16bcfd63-2803-8000-7725-b42cd05061fa@redhat.com>
 <Y4T9ejjPETS3TPx7@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y4T9ejjPETS3TPx7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/28/22 19:27, Jason Gunthorpe wrote:
> On Sun, Nov 27, 2022 at 06:49:29PM +0100, Eric Auger wrote:
>
>>> +static int iommufd_ioas_load_iovas(struct rb_root_cached *itree,
>>> +				   struct iommu_iova_range __user *ranges,
>>> +				   u32 num)
>>> +{
>>> +	u32 i;
>>> +
>>> +	for (i = 0; i != num; i++) {
>> shouldn't it be < ?
> It is logically equivalent
damn. That sometimes happens to me when staring at so much code ;-)
>
>>> +int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd)
>>> +{
>>> +	struct iommu_ioas_allow_iovas *cmd = ucmd->cmd;
>>> +	struct rb_root_cached allowed_iova = RB_ROOT_CACHED;
>>> +	struct interval_tree_node *node;
>>> +	struct iommufd_ioas *ioas;
>>> +	struct io_pagetable *iopt;
>>> +	int rc = 0;
>>> +
>>> +	if (cmd->__reserved)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
>>> +	if (IS_ERR(ioas))
>>> +		return PTR_ERR(ioas);
>>> +	iopt = &ioas->iopt;
>>> +
>>> +	rc = iommufd_ioas_load_iovas(&allowed_iova,
>>> +				     u64_to_user_ptr(cmd->allowed_iovas),
>>> +				     cmd->num_iovas);
>>> +	if (rc)
>>> +		goto out_free;
>>> +
>>> +	rc = iopt_set_allow_iova(iopt, &allowed_iova);
>> Please can you add a comment about why you need to proceed in 2 steps,
>> ie. add the ranges in a first tree and then 'swap' to the
>> iopt->allowed_tree (and eventually delete the first tree)?
> Sure
>
> 	/*
> 	 * We want the allowed tree update to be atomic, so we have to keep the
> 	 * original nodes around, and keep track of the new nodes as we allocate
> 	 * memory for them. The simplest solution is to have a new/old tree and
> 	 * then swap new for old. On success we free the old tree, on failure we
> 	 * free the new tree.
> 	 */
>
>>> +static int conv_iommu_prot(u32 map_flags)
>>> +{
>>> +	int iommu_prot;
>>> +
>>> +	/*
>>> +	 * We provide no manual cache coherency ioctls to userspace and most
>>> +	 * architectures make the CPU ops for cache flushing privileged.
>>> +	 * Therefore we require the underlying IOMMU to support CPU coherent
>>> +	 * operation. Support for IOMMU_CACHE is enforced by the
>>> +	 * IOMMU_CAP_CACHE_COHERENCY test during bind.
>>> +	 */
>>> +	iommu_prot = IOMMU_CACHE;
>> at init?
> done
>
>>> +int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
>>> +{
>>> +	struct iommu_ioas_map *cmd = ucmd->cmd;
>>> +	struct iommufd_ioas *ioas;
>>> +	unsigned int flags = 0;
>>> +	unsigned long iova;
>>> +	int rc;
>>> +
>>> +	if ((cmd->flags &
>>> +	     ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
>>> +	       IOMMU_IOAS_MAP_READABLE)) ||
>>> +	    cmd->__reserved)
>>> +		return -EOPNOTSUPP;
>>> +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
>>> +		return -EOVERFLOW;
>>> +
>>> +	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
>>> +	if (IS_ERR(ioas))
>>> +		return PTR_ERR(ioas);
>>> +
>>> +	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
>>> +		flags = IOPT_ALLOC_IOVA;
>>> +	iova = cmd->iova;
>> can be done either at initialization or only if MAP_FIXED_IOVA.
> Done
>
>
>>> +int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>>> +			       struct iommufd_ctx *ictx)
>>> +{
>> *object_id  and __reserved should be checked as per the uapi doc*
> Ohh, yes, thanks:
>
> @@ -317,6 +322,9 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>  int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>                                struct iommufd_ctx *ictx)
>  {
> +       if (cmd->object_id)
> +               return -EOPNOTSUPP;
> +
>         if (cmd->op == IOMMU_OPTION_OP_GET) {
>                 cmd->val64 = ictx->account_mode == IOPT_PAGES_ACCOUNT_MM;
>                 return 0;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index de5cc01023c0c5..bcb463e581009c 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -215,6 +215,9 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
>         struct iommu_option *cmd = ucmd->cmd;
>         int rc;
>  
> +       if (cmd->__reserved)
> +               return -EOPNOTSUPP;
> +
>         switch (cmd->option_id) {
>         case IOMMU_OPTION_RLIMIT_MODE:
>                 rc = iommufd_option_rlimit_mode(cmd, ucmd->ictx);
>
>>> +/**
>>> + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
>>> + * @size: sizeof(struct iommu_ioas_iova_ranges)
>>> + * @ioas_id: IOAS ID to read ranges from
>>> + * @num_iovas: Input/Output total number of ranges in the IOAS
>>> + * @__reserved: Must be 0
>>> + * @allowed_iovas: Pointer to the output array of struct iommu_iova_range
>>> + * @out_iova_alignment: Minimum alignment required for mapping IOVA
>>> + *
>>> + * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these ranges
>>> + * is not allowed. num_iovas will be set to the total number of iovas and
>>> + * the allowed_iovas[] will be filled in as space permits.
>>> + *
>>> + * The allowed ranges are dependent on the HW path the DMA operation takes, and
>>> + * can change during the lifetime of the IOAS. A fresh empty IOAS will have a
>>> + * full range, and each attached device will narrow the ranges based on that
>>> + * device's HW restrictions. Detatching a device can widen the ranges. Userspace
>> detaching
>>> + * should query ranges after every attach/detatch to know what IOVAs are valid
>> detach
> Done
>
>>> + * for mapping.
>>> + *
>>> + * On input num_iovas is the length of the allowed_iovas array. On output it is
>>> + * the total number of iovas filled in. The ioctl will return -EMSGSIZE and set
>>> + * num_iovas to the required value if num_iovas is too small. In this case the
>>> + * caller should allocate a larger output array and re-issue the ioctl.
>>> + */
>>> +struct iommu_ioas_iova_ranges {
>>> +	__u32 size;
>>> +	__u32 ioas_id;
>>> +	__u32 num_iovas;
>>> +	__u32 __reserved;
>>> +	__aligned_u64 allowed_iovas;
>>> +	__aligned_u64 out_iova_alignment;
>> document @out_iova_alignment?
>  * out_iova_alignment returns the minimum IOVA alignment that can be given
>  * to IOMMU_IOAS_MAP/COPY. IOVA's must satisfy:
>  *   starting_iova % out_iova_alignment == 0
>  *   (starting_iova + length) % out_iova_alignment == 0
>  * out_iova_alignment can be 1 indicating any IOVA is allowed. It cannot
>  * be higher than the system PAGE_SIZE.
>
>>> +/**
>>> + * struct iommu_ioas_map - ioctl(IOMMU_IOAS_MAP)
>>> + * @size: sizeof(struct iommu_ioas_map)
>>> + * @flags: Combination of enum iommufd_ioas_map_flags
>>> + * @ioas_id: IOAS ID to change the mapping of
>>> + * @__reserved: Must be 0
>>> + * @user_va: Userspace pointer to start mapping from
>>> + * @length: Number of bytes to map
>>> + * @iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IOVA is set
>>> + *        then this must be provided as input.
>>> + *
>>> + * Set an IOVA mapping from a user pointer. If FIXED_IOVA is specified then the
>>> + * mapping will be established at iova, otherwise a suitable location based on
>>> + * the reserved and allowed lists will be automatically selected and returned in
>>> + * iova.
>> You do not mention anything about the fact the IOCTL cannot be called
>> twice for a given @user_va w/ FIXED_IOVA
>> Refering to VFIO_DMA_MAP_FLAG_VADDR.
>  * If IOMMU_IOAS_MAP_FIXED_IOVA is specified then the iova range must currently
>  * be unused, existing IOVA cannot be replaced.
>
>>> +/**
>>> + * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
>>> + * @size: sizeof(struct iommu_ioas_copy)
>>> + * @flags: Combination of enum iommufd_ioas_map_flags
>>> + * @dst_ioas_id: IOAS ID to change the mapping of
>>> + * @src_ioas_id: IOAS ID to copy from
>>> + * @length: Number of bytes to copy and map
>>> + * @dst_iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IOVA is
>>> + *            set then this must be provided as input.
>>> + * @src_iova: IOVA to start the copy
>>> + *
>>> + * Copy an already existing mapping from src_ioas_id and establish it in
>>> + * dst_ioas_id. The src iova/length must exactly match a range used with
>>> + * IOMMU_IOAS_MAP.
>>> + *
>>> + * This may be used to efficiently clone a subset of an IOAS to another, or as a
>>> + * kind of 'cache' to speed up mapping. Copy has an effciency advantage over
>> efficiency
>>> + * establishing equivalent new mappings, as internal resources are shared, and
>>> + * the kernel will pin the user memory only once.
>>> + */
>>> +struct iommu_ioas_copy {
>>> +	__u32 size;
>>> +	__u32 flags;
>>> +	__u32 dst_ioas_id;
>>> +	__u32 src_ioas_id;
>> is src_ioas_id == dst_ioas_id allowed?
> Yes
>
>>> +/**
>>> + * struct iommu_option - iommu option multiplexer
>>> + * @size: sizeof(struct iommu_option)
>>> + * @option_id: One of enum iommufd_option
>>> + * @op: One of enum iommufd_option_ops
>>> + * @__reserved: Must be 0
>>> + * @object_id: ID of the object if required
>>> + * @val64: Option value to set or value returned on get
>>> + *
>>> + * Change a simple option value. This multiplexor allows controlling a options
>> s/a options/options
> Done
>
> Thanks,
> Jason
>
Eric

