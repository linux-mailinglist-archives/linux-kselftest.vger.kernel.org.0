Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5F241E80
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgHKQme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 12:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgHKQmd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 12:42:33 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE12206DC;
        Tue, 11 Aug 2020 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597164153;
        bh=wLDdwLUeUg+9AYUSveqoVqiy+usyp31jDtk1JImzqLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVAERsMSNloysD/HjddpKd84n+7f1cq9ngKijUztRHywo5twN2qKez8gkhyfms9SE
         mrM49ZQr3I4WWAYuYqifd5DwYmTixrI7GMOJg00pbIlHv62ELga2rA6gvo1sj52pNT
         XsXZUr+0VPAam+fjCDyVc1J59SV8EZkTMWADWr6k=
Date:   Tue, 11 Aug 2020 12:42:31 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Please pick this kunit fix for stables (5.8 & 5.7)
Message-ID: <20200811164231.GI2975990@sasha-vm>
References: <59f75dc7-3fe4-d61f-4cf1-4b922f596818@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <59f75dc7-3fe4-d61f-4cf1-4b922f596818@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 10, 2020 at 02:54:29PM -0600, Shuah Khan wrote:
>Hi Sasha,
>
>Please pick the following commit for stables Linux 5.8 and 5.7
>
>kunit: capture stderr on all make subprocess calls
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a9fcad71caa970f30aef99134a1cd19bc4b8eea

Now queued up, thanks!

-- 
Thanks,
Sasha
