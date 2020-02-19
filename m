Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718B716529F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 23:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBSWlh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 17:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbgBSWlh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 17:41:37 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6949220656;
        Wed, 19 Feb 2020 22:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582152096;
        bh=0rG2RXX8ea/4Q5kB7gw8TH6gb4P54HAvmGH4xTZEbJ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fMFgVvJZeIe0eHLSnI3i+lsObyVlYFwk/nTi6SirOo6IMZqNl4wRXOLs50ItUB+8G
         NlOTOzBiJ9Y2DlWx7IeZi8dqWlNEXTDGwOuk3tKDPlgOHBux5vr+M7j+f4mhEVYTdP
         A/iU7cJTgWbA0rPJJEDezpzndRqCC2vMLkfkvf3k=
Subject: Re: [PATCH v2] kunit: run kunit_tool from any directory
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        shuah <shuah@kernel.org>
References: <20200218221916.239951-1-heidifahim@google.com>
 <be2a28e9-6e5b-37a7-b298-2fef410d3be3@kernel.org>
 <CAMVcs3uRj2uhFJXA+GEZmNjvNFF+3ODNmAON++scx26tnVhScA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <fc29461d-56c0-b23f-f8e8-23a88e9e471f@kernel.org>
Date:   Wed, 19 Feb 2020 15:41:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMVcs3uRj2uhFJXA+GEZmNjvNFF+3ODNmAON++scx26tnVhScA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/19/20 3:38 PM, Heidi Fahim wrote:
> On Wed, Feb 19, 2020 at 2:18 PM shuah <shuah@kernel.org 
> <mailto:shuah@kernel.org>> wrote:
> 
>     Hi Heidi,
> 
>     On 2/18/20 3:19 PM, Heidi Fahim wrote:
>      > Implemented small fix so that the script changes work directories
>     to the
>      > root of the linux kernel source tree from which kunit.py is run. This
>      > enables the user to run kunit from any working directory. Originally
>      > considered using os.path.join but this is more error prone as we
>     would
>      > have to find all file path usages and modify them accordingly. Using
>      > os.chdir ensures that the entire script is run within /linux.
>      >
>      > Signed-off-by: Heidi Fahim <heidifahim@google.com
>     <mailto:heidifahim@google.com>>
>      > Reviewed-by: Brendan Higgins <brendanhiggins@google.com
>     <mailto:brendanhiggins@google.com>>
> 
>     Thanks for  the patch. In the future please include changes from v1
>     to v2.
> 
>     I am assuming this v2 addresses Frank's comments.
> 
> 
> Sorry about that! Yes the only change here was in the commit message 
> addressing Frank's comment.
> 

Great. I will pull this in for 5.6-rc4.

thanks,
-- Shuah

