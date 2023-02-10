Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A21692BA4
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 00:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBJXwI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 18:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBJXwH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 18:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831A63773A
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 15:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676073074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxG2e2jd/Ft5YwmWrl0Bp+sdIxiuwt9Kd232cbEoDxs=;
        b=fP8ygXSKd9toKX+RNShuSUKdxRME1pGdqCwLayp+DpYhmf1POP0pwWee5DBrWIA58ueABp
        qArzQS05WnpZhtnfSAqEMC8Rgrsqfdc4LkiYVbo5Cx0Qd8roC2KrsOSOBM6q8Vb5WUmx1f
        N+laIKD5Wx30RocUAPI7gnZVZikg0wo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-128-4H8-7s7pNXywnpn2B526hg-1; Fri, 10 Feb 2023 18:51:13 -0500
X-MC-Unique: 4H8-7s7pNXywnpn2B526hg-1
Received: by mail-il1-f199.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so5312407ilj.14
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Feb 2023 15:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxG2e2jd/Ft5YwmWrl0Bp+sdIxiuwt9Kd232cbEoDxs=;
        b=WUAM8F7lEzjjlQtSG+SVj/8w9I7xULNM/GISRO68Nb7eaY+Ufdeza691K7HSMRpK0F
         WFaKaIG/Gdj5bZq99isQE/rRfD5CNQ+ogWwmDCDNtnDEGDtJ2TqLsXmZy+igFUMgLnip
         RE6gSbJoFLVwCtnX6DIuyvLyracIeCnRdOq+myXQHC/9O9hVhBFMNUt8dkTq5lav+HBC
         pwDAdV/bnOxJK0IAd4vuEvARU8RgXw+EVvYt34dyuy+x84ImuQxwaFRs2R0axOeIYke0
         tCkx2HFZ+FzGp8Rw7cMS40si71WMAq0moQtq9UeI0+KlrBsQ0jnlur0N4aLfcgjfDpQH
         OKZw==
X-Gm-Message-State: AO0yUKUpXYgTlslHecZuFvRN0yGByynVK0FTnvQJ+OiRtVAh+ukNOktg
        oOsJIi7J3ywRh4TnQs5ir/sby8EBRJGCa5gHJxBtwaw19UNv394rfK3Aoadn5b4pP2SIniqEOlP
        8W4Cj0eChTqVstFMJsxdAU6GulPol
X-Received: by 2002:a05:6e02:19cf:b0:315:2b7c:3bcd with SMTP id r15-20020a056e0219cf00b003152b7c3bcdmr227353ill.23.1676073072667;
        Fri, 10 Feb 2023 15:51:12 -0800 (PST)
X-Google-Smtp-Source: AK7set842Z0z6M94KbGdEcodes2zf58/JeUwSHWqWrZfu04modlNc2olG9foLCn5r2HwqlyIBAtLsA==
X-Received: by 2002:a05:6e02:19cf:b0:315:2b7c:3bcd with SMTP id r15-20020a056e0219cf00b003152b7c3bcdmr227334ill.23.1676073072410;
        Fri, 10 Feb 2023 15:51:12 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t26-20020a02c49a000000b0035678e2e175sm1766330jam.50.2023.02.10.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:51:11 -0800 (PST)
Date:   Fri, 10 Feb 2023 16:51:10 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <shuah@kernel.org>,
        <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <20230210165110.4e89ce55.alex.williamson@redhat.com>
In-Reply-To: <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
        <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Feb 2023 13:17:54 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> qemu has a need to replace the translations associated with a domain
> when the guest does large-scale operations like switching between an
> IDENTITY domain and, say, dma-iommu.c.
> 
> Currently, it does this by replacing all the mappings in a single
> domain, but this is very inefficient and means that domains have to be
> per-device rather than per-translation.
> 
> Provide a high-level API to allow replacements of one domain with
> another. This is similar to a detach/attach cycle except it doesn't
> force the group to go to the blocking domain in-between.
> 
> By removing this forced blocking domain the iommu driver has the
> opportunity to implement an atomic replacement of the domains to the
> greatest extent its hardware allows.
> 
> It could be possible to adderss this by simply removing the protection
> from the iommu_attach_group(), but it is not so clear if that is safe
> for the few users. Thus, add a new API to serve this new purpose.
> 
> Atomic replacement allows the qemu emulation of the viommu to be more
> complete, as real hardware has this ability.

I was under the impression that we could not atomically switch a
device's domain relative to in-flight DMA.  IIRC, the discussion was
relative to VT-d, and I vaguely recall something about the domain
needing to be invalidated before it could be replaced.  Am I
mis-remembering or has this since been solved?  Adding Ashok, who might
have been involved in one of those conversations.

Or maybe atomic is the wrong word here since we expect no in-flight DMA
during the sort of mode transitions referred to here, and we're really
just trying to convey that we can do this via a single operation with
reduced latency?  Thanks,

Alex

> All drivers are already required to support changing between active
> UNMANAGED domains when using their attach_dev ops.
> 
> This API is expected to be used by IOMMUFD, so add to the iommu-priv
> header and mark it as IOMMUFD_INTERNAL.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu-priv.h |  4 ++++
>  drivers/iommu/iommu.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index 9e1497027cff..b546795a7e49 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -15,4 +15,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>  	 */
>  	return dev->iommu->iommu_dev->ops;
>  }
> +
> +extern int iommu_group_replace_domain(struct iommu_group *group,
> +				      struct iommu_domain *new_domain);
> +
>  #endif /* __LINUX_IOMMU_PRIV_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a18b7f1a4e6e..15e07d39cd8d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2151,6 +2151,34 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_group);
>  
> +/**
> + * iommu_group_replace_domain - replace the domain that a group is attached to
> + * @new_domain: new IOMMU domain to replace with
> + * @group: IOMMU group that will be attached to the new domain
> + *
> + * This API allows the group to switch domains without being forced to go to
> + * the blocking domain in-between.
> + *
> + * If the currently attached domain is a core domain (e.g. a default_domain),
> + * it will act just like the iommu_attach_group().
> + */
> +int iommu_group_replace_domain(struct iommu_group *group,
> +			       struct iommu_domain *new_domain)
> +{
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	if (ret)
> +		__iommu_group_set_domain(group, group->domain);
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);
> +
>  static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
>  {
>  	const struct iommu_ops *ops = dev_iommu_ops(dev);

