Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C933A3FA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhFKJ5d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 05:57:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:17450 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKJ5c (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 05:57:32 -0400
IronPort-SDR: VtVoc5iLZKz0CK2XAjM2ytr9skreuYSnr6KE3Zhgf4QbqvQReK6FzK5IBpeNjp1ZDrietAwYhV
 WRgJDkd/xnJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="205455825"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="205455825"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 02:55:32 -0700
IronPort-SDR: zQiO9KYtol5E/fgSyNcc7ANqdkyiVXaJgjmcQuhtPZEO8lTdqK/E21ixW/LrjKQA7pZGOIVNLH
 CLSxhkuyOuhQ==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="552648386"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 02:55:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lrdsr-001TgV-PV; Fri, 11 Jun 2021 12:55:25 +0300
Date:   Fri, 11 Jun 2021 12:55:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, tales.aparecida@gmail.com
Subject: Re: [PATCH v3 0/1] lib: Convert UUID runtime test to KUnit
Message-ID: <YMMzDUVOlJcw63lf@smile.fi.intel.com>
References: <20210610163959.71634-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210610163959.71634-1-andrealmeid@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 10, 2021 at 01:39:58PM -0300, André Almeida wrote:
> Hi,
> 
> This patch converts existing UUID runtime test to use KUnit framework.
> 
> Below, there's a comparison between the old output format and the new
> one. Keep in mind that even if KUnit seems very verbose, this is the
> corner case where _every_ test has failed.

Btw, do we have test coverage statistics?

I mean since we reduced 18 test cases to 12, do we still have the same / better
test coverage?

-- 
With Best Regards,
Andy Shevchenko


