Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFB1B16D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDTUXL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDTUXK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 16:23:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334BC061A10
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 13:23:10 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u15so11553868ljd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CuRp/kkTGXEMux5bgsIo3QW+RdRZxdATUglGSRF3hAg=;
        b=c5S3+Z5nEopbu09u5DjyVYMtQfUwx7xcO7OiL/GTmj2QqkZy/KM/OvgBGCCJQugEl7
         s6r/w8EYr8aljdzxYprJ07sXIvRPAgw58EhTUhgUJKIavNbBiScdXVZYCXmlQ+LxxI8B
         8luq4d1ebkxREBHZmWjpTFMo5qLJWzg5A0XYtPkRPIx4OFABhOvacveltjJc5Wdda7mx
         3k5HfOTiJxkyjX2ZJKJi2OCmJGleHmT8Qb2ZggMD2mVFt1y9/00XrOgUhz303UrbHTTn
         RKw3ufXsHZlocyVOTMnJ7bxflOhCfoIqXjfr6b5Qmlu9zXnhzLVXmlsnDgJ56eHRYH6S
         5YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CuRp/kkTGXEMux5bgsIo3QW+RdRZxdATUglGSRF3hAg=;
        b=Mx1d0h9v1o5P0Im3N6kyDUcbW3FhnT1W+LwtOlFLbt8v74RGLcv3PnICwN/9zK64+K
         wJguobtvGsG7ABbSjjA1OR8i9JxHA0VioS/CNc5sAf6gVfsdIsbJvhzQOh5vgQX3tp2J
         2fB5evkSw7YDvL45+B/BUr4jdDZitCq6e4uU/qfwiv8iWNx786X8tw6hIsOdUPOfxG1W
         e3jeQHaZ8hUr8LOMTGwMmsP0MbHuSiG7TXQLDQBQrjK9a72ff4fu9n4/5AbyTm7jI3i4
         J87gkPbXV7Tn48jsERTzj5oYQjpDbtQFRLLUyxcJJx2r5DDJ26Okk2Rqy9P5CEswjDbE
         5yBA==
X-Gm-Message-State: AGi0PuYT8culk6qtPaIkevcAQTTVZV+ZXyaISAvlpRuVqlTv+wbX9JeZ
        DC69Ghwd4oYOLIPdCOhTTv5VqA==
X-Google-Smtp-Source: APiQypIe7ofdBVgkbqdERU9/MDZTLo5v/el4i+71zRDMmRE4Q9LM7F+EC7G8sK2mDnu0mQPPmuMGzg==
X-Received: by 2002:a2e:8805:: with SMTP id x5mr11577593ljh.223.1587414188514;
        Mon, 20 Apr 2020 13:23:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x24sm344419lfc.6.2020.04.20.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:23:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 07398103037; Mon, 20 Apr 2020 23:23:12 +0300 (+03)
Date:   Mon, 20 Apr 2020 23:23:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Colin King <colin.king@canonical.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] selftests: khugepaged: fix several spelling
 mistakes
Message-ID: <20200420202311.srpxl7jrbdjus642@box>
References: <20200420084241.65433-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420084241.65433-1-colin.king@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 20, 2020 at 09:42:41AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There a are several spelling mistakes in various messages. Fix these.
> 
> There are three spelling mistakes in various messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks a lot.

Andrew, could you fold them in? Or should I resend?

-- 
 Kirill A. Shutemov
