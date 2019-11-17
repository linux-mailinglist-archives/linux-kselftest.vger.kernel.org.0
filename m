Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789BAFF8D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2019 12:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfKQLDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Nov 2019 06:03:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40100 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfKQLDW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Nov 2019 06:03:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep1so663293pjb.7;
        Sun, 17 Nov 2019 03:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oidSitOSx3wz/zOT9+cz4soIOB6y/ZqJ5xkv2u37mMg=;
        b=jJEJMNfRpHtXmJckbTZB9ZNHCq2xiXBw90gY9gIbEXxRovl7hLntxcbbaAJAf2ud+b
         MXSNvcdZDb+0nshW/ucfoHsxQ8QRBHxgRSL5szZH88Wyc09iVGespARjnFZ+xtCUCsX4
         QeAd9DLUmgCNls3d3COIAwF12Lgg3kyUymoZejLgB9wVH8w6evTKORKdk+n2d5Jftvcc
         FPi2UbmDvlAMhMpG6uftA5lkaa/oMW3HLrOKZHXfX9i8BLGQF/9S3WakXBP3t1bJi7+u
         HaMNelmGG9FA6kvTeLFdgDEtFNwk5rBux4rm6+hvJms+0BAmsI1d43UY0aYqS79CZYDL
         tCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oidSitOSx3wz/zOT9+cz4soIOB6y/ZqJ5xkv2u37mMg=;
        b=MbiDtHiaPsQQIqzy439+cXoNePJfpmrpAB6XZbFEvkN2BLTCgLM5tt3TtRlPAZsEjU
         leFTFk+7AqBtEcqVS0eJ/OKp/cdbRI4izOhDygfSfrvAqk0IanPXHVrgq0PZHI847hCh
         f9g4dH5mi3Rq/rUNot2FPX+9oPeTRW+xb0E6ZjecvjjOMAqVOgHYWA4fzBvQoUGWmDCZ
         MRx8K2a5OI3GLWkSNFXWwAnBTH7QqSiCPMnUkctG5yppFUMgB9KyK6vNYo4RsCLAV5JP
         uddddY+L1cMsrXB8g5aB8fcfYrcFaO1fbyRUOS5UMTi5nYBsWm4dlt3Fyryv1ML/KNQF
         b5YQ==
X-Gm-Message-State: APjAAAWBn+fiQnhuPErPN+8cKsMBEunoqB9mQ76bC439FCDUTBIImuV/
        R28Cy5Ovy39qR+vOyT7RNw==
X-Google-Smtp-Source: APXvYqx+d4UcV0qPDI11BREyaM8WXS2PpgQ5hEDrsy14K2J9lpPJH9GED3bAD68F8Q4kG1EIrj8SUg==
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr30970268pju.141.1573988601826;
        Sun, 17 Nov 2019 03:03:21 -0800 (PST)
Received: from [172.24.28.130] ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id w2sm18153667pfj.22.2019.11.17.03.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 03:03:21 -0800 (PST)
Subject: Re: [PATCH v8 5/9] hugetlb: disable region_add file_region coalescing
To:     Mina Almasry <almasrymina@google.com>, mike.kravetz@oracle.com
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-5-almasrymina@google.com>
From:   Wenkuan Wang <wwk0817@gmail.com>
Message-ID: <010d5a90-3ebf-30e5-8829-a61f01b6f620@gmail.com>
Date:   Sun, 17 Nov 2019 19:03:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030013701.39647-5-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/30/19 9:36 AM, Mina Almasry wrote:
> /* Must be called with resv->lock held. Calling this with count_only == true
> * will count the number of pages to be added but will not modify the linked
> - * list.
> + * list. If regions_needed != NULL and count_only == true, then regions_needed
> + * will indicate the number of file_regions needed in the cache to carry out to
> + * add the regions for this range.
> */
> static long add_reservation_in_range(struct resv_map *resv, long f, long t,

Hi Mina,

Would you please share which tree this patch set used? this patch 5/9 can't be
applied with Linus's tree and add_reservation_in_range can't be found.

Thanks
Wenkuan

> - bool count_only)
> + long *regions_needed, bool count_only)
> {
> - long chg = 0;
> + long add = 0;
> struct list_head *head = &resv->regions;
> + long last_accounted_offset = f;
> struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> - /* Locate the region we are before or
