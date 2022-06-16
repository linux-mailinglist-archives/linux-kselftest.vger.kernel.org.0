Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5B54EAFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378460AbiFPUY2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 16:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378368AbiFPUY1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 16:24:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B572D5B895;
        Thu, 16 Jun 2022 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655411066; x=1686947066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u7s3vzw8pok7nOqE3kB+YqdXs3ysm3lKy+WAyqtMJpg=;
  b=Hq0qUsiPn71fY6AmoCFoEq+ssV/SmquTT/k6SZ96l+La1t344v9feHf0
   qYoNTRSNj0WZVrCLxDGy+iHJFS0lz3dX3+QNu57VefMLmp6wSYVAJRMci
   TWG3RUjYoVDA/WFsgsisGJxS0FQ+UlbD/ZZBZ3XOX3KJLuguR1+lj67ea
   0BLr4tBzHP9YoRgSRpq+UbrMCaA1mPZhnZhhMYkL43Pw3xA67EgdBCDik
   nY0/Kd58ogptcS6Bd3/BiFqtOh1/8M82s/XWix0RUYzMttVnkswMG5i9H
   H1XcYNM7Lft+2fQkCbO3xgHiGGtZfht7jkNrdalqGruXzav3IkLRgHAl7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278140500"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278140500"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:24:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="641715046"
Received: from rrmiller-mobl.amr.corp.intel.com (HELO [10.212.205.54]) ([10.212.205.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:24:25 -0700
Message-ID: <9f1d9f74-e6fd-c6cc-4999-61eccadc7bf2@intel.com>
Date:   Thu, 16 Jun 2022 13:24:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 3/6] testing/pkeys: Add additional test for
 pkey_alloc()
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, ira.weiny@intel.com,
        linux-api@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-4-ira.weiny@intel.com>
 <b4f8ca28-f24a-d619-3682-d92fb35db56d@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <b4f8ca28-f24a-d619-3682-d92fb35db56d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/16/22 12:25, Sohil Mehta wrote:
> Should we have different return error codes when compile support is 
> disabled vs when runtime support is missing?

It doesn't *really* matter.  Programs have to be able to run on old
kernels which will return ENOSYS.  So, _when_ new kernels return ENOSYS
or ENOSPC is pretty immaterial.
