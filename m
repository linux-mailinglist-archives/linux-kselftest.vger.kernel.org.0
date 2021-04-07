Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0CB3572D9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354668AbhDGRMb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 13:12:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:28524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235711AbhDGRMa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 13:12:30 -0400
IronPort-SDR: uw2iSvQo9hZjp1TTqCh4lOUF75Yd+qYrFxVtheE62p/LK2Ws9ZllxZLAMc49IrohEOhMwb2WEo
 1712bGtAGp3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="191196299"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="191196299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:12:21 -0700
IronPort-SDR: rObUCVsnK0wZAWxKAigIfSe2X5gjQjofnzQxF1w2NbOThugQZHJZI5P4OZIQsdqYxktPIUzHiB
 8IxKtWpBYtyA==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="421790852"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:12:20 -0700
Date:   Wed, 7 Apr 2021 17:12:14 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/resctrl: Change a few printed messages
Message-ID: <YG3n7gsIhqOGjltv@otcwcpicx3.sc.intel.com>
References: <20210406005242.3248706-1-fenghua.yu@intel.com>
 <67062f6c-d09a-f8e0-4d22-49c4452d0552@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67062f6c-d09a-f8e0-4d22-49c4452d0552@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Shuah,

On Wed, Apr 07, 2021 at 08:33:23AM -0600, Shuah Khan wrote:
> On 4/5/21 6:52 PM, Fenghua Yu wrote:
> > -	ksft_print_msg("%s cache miss rate within %d%%\n",
> > -		       ret ? "Fail:" : "Pass:", max_diff_percent);
> > +	ksft_print_msg("Check cache miss rate within %d%%\n", max_diff_percent);
> 
> You need %s and pass in the ret ? "Fail:" : "Pass:" result for the
> message to read correctly.

Should I keep the ":" after "Pass"/"Fail"?

> 
> I am seeing:
> 
> # Check kernel support for resctrl filesystem
> 
> It should say the following:
> 
> # Fail Check kernel support for resctrl filesystem

i.e. should the printed messages be like the following?
# Fail: Check kernel support for resctrl filesystem
or
# Pass: Check kernel support for resctrl filesystem

Thanks.

-Fenghua
