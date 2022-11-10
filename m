Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD71E623E9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKJJbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 04:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKJJbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 04:31:05 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E760D9;
        Thu, 10 Nov 2022 01:31:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q9so1450981pfg.5;
        Thu, 10 Nov 2022 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EvpDdZ4hxcipg3MQAInCVCspubJ3uS0BC6hXCLOf3U=;
        b=VLao0cXkAY92G2p1UszK3LD1hHzo5JKXYUXoOGc1CU/6NqeHnqjaxahdLAW55ynq6a
         HW0ColHyQXlrfep5aM4JgxTYFd2eJ9eYp4eHMWRExB5lH9CotPkKJ9gBt6CcKWf+b7+b
         LLErN5sw4qWqixwC3GqNeRDh6EwxVLM2ESzeOLCQgXOV93rn0vFlmOpW49YWoQqPXCzR
         3lIi3Z1cdaapAKGETVC9o0nlnAogohAPpHpLQ65KW6UIImwCiYBJYT9IAm4PcvmA4xpg
         AXrKN7MZyLeG7vZcizsK2unw6/+ZQ1EWybqZ2gnqROoGVHcuFu61S0JkGf/zsuy+fATw
         h+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EvpDdZ4hxcipg3MQAInCVCspubJ3uS0BC6hXCLOf3U=;
        b=PAuHdb9SQ6saMI8kGs7o32LBB3qAXIOhjdTkxHdW7xhEsol5VM/Cxd8BNb16XNhEmT
         0Uk2Bo7V2m3ahjZhmUo8A1HrqfRpW9HqMJWU2Ac3c4May58gcGcF2Xq/Eb+pQ7FB+Hg1
         SswlWc2SDcjMmoio/cDgy85PNGork99kmo7RbU6q03jZSGjtROQ7YUOaD+UpZ5BYLkrL
         fOntuGzXRCo0WgdyLcfwL8gyXRY0oV+Pb/vks2qe2dWECny1qwHnr/6RTFbl4Agm0v+F
         CNFzKRZ6VZgDImuw7dkKvUWfdGIYL5PmEhLgQwfFpRbvIna7pIqy6va/bOGREdNOe7Lr
         83wg==
X-Gm-Message-State: ACrzQf2cEUCzk/FBktQ+F28fOFCOJRw8tu35Mz2HWMr36Utn0220m4Ci
        R0OrPmkRVURF7H3TcfNYYjM=
X-Google-Smtp-Source: AMsMyM78iiI/P+DpqpOA4p4lxe7GrKwstfV8mS9lP7o9wCPkGkzc4m7eiJTeoMbliQXRPEaHy5Nm5w==
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id a145-20020a621a97000000b00562558712d6mr62997671pfa.37.1668072663634;
        Thu, 10 Nov 2022 01:31:03 -0800 (PST)
Received: from debian.me (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090a384300b00213c7cf21c0sm2677928pjf.5.2022.11.10.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 01:31:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id A3B96104223; Thu, 10 Nov 2022 16:30:59 +0700 (WIB)
Date:   Thu, 10 Nov 2022 16:30:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
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
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Message-ID: <Y2zE0zfnQ7mt740i@debian.me>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 08:48:57PM -0400, Jason Gunthorpe wrote:
> From: Kevin Tian <kevin.tian@intel.com>
> 
> Add iommufd into the documentation tree, and supply initial documentation.
> Much of this is linked from code comments by kdoc.
> 

The patch also exposes htmldocs warnings as Stephen Rothwell has
reported on linux-next [1] due to the copyright comments mistaken for
kernel-doc comments, so I have applied the fixup:

---- >8 ----

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 536a34d099968d..76b3761a89423e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+/*
+ * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommufd.h>
 #include <linux/slab.h>
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 1eeb326f74f005..fc4c80ec0511f4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (C) 2021 Intel Corporation
+/*
+ * Copyright (C) 2021 Intel Corporation
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  *
  * iommufd provides control over the IOMMU HW objects created by IOMMU kernel

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
