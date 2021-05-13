Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C632537FE5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 21:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEMToK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 15:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhEMToK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 15:44:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 977BD613F1;
        Thu, 13 May 2021 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620934980;
        bh=8oR+9d7U4Qy1R7KLwAPmIYcBlpcTBiiy0qvA3IibprE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqFJpdJj8cWYGVYfWoYDieKuJbkz+Xp3cqKC5G7hb95RnnbX3VUhTk+cerDT3VDIO
         YoqW3T8mIrSesmHESiDgMRAxOu2ow8OXlqNJaMa9ovRVGnZOiWiI6sZzV1E3nh5wwS
         Nb2Ysc22uIt3IqI91yvLEoB27VO4GnkxYFN9FJJQ=
Date:   Thu, 13 May 2021 21:42:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] device property: Remove some casts in
 property-entry-test
Message-ID: <YJ2BQeINNBQMRaVU@kroah.com>
References: <20210513193204.816681-1-davidgow@google.com>
 <20210513193204.816681-4-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513193204.816681-4-davidgow@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 12:31:58PM -0700, David Gow wrote:
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in property-entry-test are no longer required.
> 
> Remove the unnecessary casts, making the conditions clearer.
> 
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
