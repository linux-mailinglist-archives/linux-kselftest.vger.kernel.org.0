Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAF28F5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 05:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbfEXDCV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 23:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387408AbfEXDCV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 23:02:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99F92177E;
        Fri, 24 May 2019 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558666940;
        bh=dLowSz66hg2+3Cg2JldMlBCLZPDiSfNmkpIaRGvDtA4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YY7KTf0+s/PusMSewnPa5dPJYAJcRDvmYdAp38Wmh5PZD6HqaJuA6lxWK0bfpRrNB
         suumRziElo40+/R//CwlL/CwT1SmFfQqitUEwHWrU0sqFkqI46j9G7KxQCeU3bmBql
         edE2vg8ZzyKZxZsKOfQpjmFYmSfKAPzcTcArfiPE=
Subject: Re: [PATCH selftests 0/2] Add checkbashisms meta-testcase
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <155079878723.5157.12433171255092403676.stgit@devbox>
 <20190323192746.59739e5e9ea0445791ac14ed@kernel.org>
 <20190523223114.4feb6239@oasis.local.home>
From:   shuah <shuah@kernel.org>
Message-ID: <f125dc4c-0099-d2e2-b295-26a4619d1ee5@kernel.org>
Date:   Thu, 23 May 2019 21:02:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523223114.4feb6239@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/23/19 8:31 PM, Steven Rostedt wrote:
> 
> Shuah,
> 
> Want to take this or would you want me to?
> 
> -- Steve
> 
> 

I can take them through my tree.

thanks,
-- Shuah

