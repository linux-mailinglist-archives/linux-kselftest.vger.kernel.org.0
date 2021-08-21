Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C93F393D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhHUHNW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Aug 2021 03:13:22 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:59738 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231738AbhHUHNV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Aug 2021 03:13:21 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CB4FB182CED28;
        Sat, 21 Aug 2021 07:12:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 6C48B1124F5;
        Sat, 21 Aug 2021 07:12:40 +0000 (UTC)
Message-ID: <4bf2c7360206025731928fa1c8ad95faa9e65ab8.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Date:   Sat, 21 Aug 2021 00:12:38 -0700
In-Reply-To: <7eda27d1-9e9f-dfd6-3a54-6c592a797ea5@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
         <20210818154646.925351-2-efremov@linux.com>
         <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
         <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
         <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
         <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
         <ac2587d3d4b7ce87e8922380e36d7864bfb54262.camel@perches.com>
         <7eda27d1-9e9f-dfd6-3a54-6c592a797ea5@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.77
X-Stat-Signature: e6zddby7k45gc1jw8hrj6auapwibzku5
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6C48B1124F5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19GFSb9ojxZ31XdQAhWXKFgy+pom9K3j9o=
X-HE-Tag: 1629529960-591553
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 2021-08-21 at 09:47 +0300, Denis Efremov wrote:
> 
> On 8/20/21 1:17 AM, Joe Perches wrote:
> > 
> > And I'm not sure if this particular ERROR is that useful overall.
> 
> I find it useful to check commit-id and that it matches a title.
> It's easy to make a typo in commit-id and get an invalid one.

That's true, but I meant requiring the sha1 hash to contain both
the word "commit" and use ("title").

Looking at checkpatch's errors produced by this GIT_COMMIT_ID
test makes the required form seem a bit too inflexible to me.

For instance: a sha1 hash may be repeated in a commit message where
the first instance has the correct form but the second use is just
the hash and the warning is still produced.


