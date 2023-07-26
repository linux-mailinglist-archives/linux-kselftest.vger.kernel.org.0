Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9841A763DC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGZRfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 13:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjGZRfO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 13:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6C2696
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690392867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L06ULfrhr6hW9gvP83AY+VEDaqsbr34/NwjBXuEOU0w=;
        b=NyYImzB2t4fmQ2XlaHUQ5yNU2NgoI3wfyEHLAMSk/wA7QfDDIePTy2AUK5CVLC2oj3xl8o
        89e/40tBMpNsr1C0940EGxO27MpaE5vlMHO9/R4bn4fZdG74tCNi1g9viOWnDi2SuCy2J4
        xjVDrLnbdj3ipPft8GBEiSTddK31NeI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-5qqH8IYbNdiaaIo2TkpNRA-1; Wed, 26 Jul 2023 13:34:26 -0400
X-MC-Unique: 5qqH8IYbNdiaaIo2TkpNRA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-78bc35225b7so1395239f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 10:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690392866; x=1690997666;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L06ULfrhr6hW9gvP83AY+VEDaqsbr34/NwjBXuEOU0w=;
        b=Gd0wxvdCKxMFfL0d5R7OpFUXLB39MSGeCceuW9nKzfWjbMA1sSGHDHNNTQ9pmHcRx0
         PwKF2XDhKi5CWWcRvs4427k3BwYhVP8SC9DCm4DcpVUhsXqP+jWZ6svFQsWORlkeirMr
         9ABGI9jsR5r9zueRfb9sbLXXztPubsSVXJMfrUnDj/R5iXUdc7tGhXO/GCWlLogeuJhU
         T77qIdqbhqUmuRNhLvW+oVe0r5uALw5Rcmp9mMR8joFk4EHp8+DcCz2/ZHc/MHk0UFAp
         UEUDDgKiUHQ95K8debNlszOVw2uOOzw4AVXOOSIWiE9TGmq+Km0SaFbPiZbW9u3v3+Le
         apBg==
X-Gm-Message-State: ABy/qLZHURn1QRBPuZ1FvbSXKtYt/UYqpTUj31KlXTdPB3A8OHUiZpDp
        O9T5jQNAjn67KpJ1bABJZeZ7nykgIDi8NP/VUmD3V9D2fn7B/ni7YSd034MzBSpQhb91oe8vwY/
        /LFg3n8P6CiI5/xeKGRxyq/jxp2EY
X-Received: by 2002:a05:6602:19c7:b0:783:6906:a32c with SMTP id ba7-20020a05660219c700b007836906a32cmr2715317iob.16.1690392865896;
        Wed, 26 Jul 2023 10:34:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGr/w0JObmLyn2KNA8gvVrm90xfj5H02NMUwVxRdYRCVlbW1sfxWsJzqC1FqZ4V7KdvwQIing==
X-Received: by 2002:a05:6602:19c7:b0:783:6906:a32c with SMTP id ba7-20020a05660219c700b007836906a32cmr2715306iob.16.1690392865656;
        Wed, 26 Jul 2023 10:34:25 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id p16-20020a02b390000000b004300d87030csm546160jan.109.2023.07.26.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 10:34:25 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:34:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: Re: [PATCH v8 4/4] vfio: Support IO page table replacement
Message-ID: <20230726113424.0e016e07.alex.williamson@redhat.com>
In-Reply-To: <182b79f3838f84f220ede6089a0326b6f3f44acf.1690226015.git.nicolinc@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
        <182b79f3838f84f220ede6089a0326b6f3f44acf.1690226015.git.nicolinc@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 24 Jul 2023 12:47:07 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> Now both the physical path and the emulated path should support an IO page
> table replacement. Call iommufd_device_replace/iommufd_access_replace(),
> when vdev->iommufd_attached is true.
> 
> Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI header.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/vfio/iommufd.c    | 11 ++++++-----
>  include/uapi/linux/vfio.h |  6 ++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> 
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index 4d84904fd927..82eba6966fa5 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -146,9 +146,9 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
>  		return -EINVAL;
>  
>  	if (vdev->iommufd_attached)
> -		return -EBUSY;
> -
> -	rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
> +		rc = iommufd_device_replace(vdev->iommufd_device, pt_id);
> +	else
> +		rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
>  	if (rc)
>  		return rc;
>  	vdev->iommufd_attached = true;
> @@ -223,8 +223,9 @@ int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
>  	lockdep_assert_held(&vdev->dev_set->lock);
>  
>  	if (vdev->iommufd_attached)
> -		return -EBUSY;
> -	rc = iommufd_access_attach(vdev->iommufd_access, *pt_id);
> +		rc = iommufd_access_replace(vdev->iommufd_access, *pt_id);
> +	else
> +		rc = iommufd_access_attach(vdev->iommufd_access, *pt_id);
>  	if (rc)
>  		return rc;
>  	vdev->iommufd_attached = true;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index fa06e3eb4955..537157ff8670 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -939,6 +939,12 @@ struct vfio_device_bind_iommufd {
>   * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
>   * allowed on cdev fds.
>   *
> + * If a vfio device is currently attached to a valid hw_pagetable, without doing
> + * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
> + * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
> + * as a hw_pagetable replacement, will replace the device's currently attached
> + * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
> + *
>   * Return: 0 on success, -errno on failure.
>   */
>  struct vfio_device_attach_iommufd_pt {

