Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84014380387
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 08:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhENGJo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 May 2021 02:09:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:26236 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhENGJn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 May 2021 02:09:43 -0400
IronPort-SDR: 3Xyli9/7yfOlocWwXKI+TkK4REjlJmT25GsS75wMtNI62bY96ULEh5VLAvEEpCnOe0uBGfermr
 wjOXuYnfuI6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200173452"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="200173452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 23:08:32 -0700
IronPort-SDR: OVpRxzo16RRPvJ8fQmnwz3lhFfI4tXFxq7IabNxvPKMhjhL+sHcy58mMQEQRrWEfnCm17VgK6F
 88xToPKlXcyg==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="624250058"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 23:08:29 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 14 May 2021 09:06:18 +0300
Date:   Fri, 14 May 2021 09:06:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 07/10] thunderbolt: test: Remove sone casts which are
 no longer required
Message-ID: <20210514060618.GA3511397@lahna.fi.intel.com>
References: <20210513193204.816681-1-davidgow@google.com>
 <20210513193204.816681-7-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513193204.816681-7-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Thu, May 13, 2021 at 12:32:01PM -0700, David Gow wrote:
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in the thunderbolt KUnit tests are no longer
> required.
> 
> Remove the unnecessary casts, making the conditions clearer.
> 
> Signed-off-by: David Gow <davidgow@google.com>

Looks good.

Does this go through KUnit tree or you want me to take it? In case of
the former feel free to add:

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
