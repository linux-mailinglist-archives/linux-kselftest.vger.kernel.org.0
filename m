Return-Path: <linux-kselftest+bounces-22452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D19D60F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 15:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E2FB28E31
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14713D53B;
	Fri, 22 Nov 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfs6IOil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6D2D05E;
	Fri, 22 Nov 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287386; cv=none; b=L9RpQq7Jq9W6VIH9CTBzB3clfdM+hsGvXoomEvAHZCFahR80sh85GCeDmWa+cwqP4V+824csL0HnXj/4xHRi9oOIbI8Q6Htun5/oIWvfP/YM9VDGAZQMjCXU9zZ6tnZ3h86KO0a0uD6mN+xYffK1P/WUkdhgCdhCa8xhPgTWb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287386; c=relaxed/simple;
	bh=IJD9+fN6CAkrQCDzVNHJ1JBFqe348mr3KLpfkmDnjMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWX67WAT1KpY+PQ0XLPlxqB1shLq5ZhLKOYmdPlugX+W2KnYth51rF5CmuvUqOBSJnDsTJnu6omoxiX2LzLP2NEpp4J5CT7wQ7GDCAkOnLAF9ITR8234bDwk8/Rzpftw43nJxG+pq3gXcZ5Hd6FrHxiXcik0YD1MUditdOcwqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfs6IOil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EF0C4CECE;
	Fri, 22 Nov 2024 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732287386;
	bh=IJD9+fN6CAkrQCDzVNHJ1JBFqe348mr3KLpfkmDnjMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tfs6IOilZrtpApfBIYDWqnCl9bmZ25XUwTl9MZwFF0BzwhEEwTMkevLPcx0PVPhWb
	 ZqgTQgZXX1Zy7ttlg62K6CM5aGb30IjpFIzU6bWmgIN3f5aFe8JUDRe2bhzmXYgJl9
	 A4Oks6s03OML0nd91d478gwH3THLhSdkNzIlHY9IuVQ17u3zQud5v1LyFPtK8I0Tu2
	 Mh8NzfY2NrxrhvGz9AAe0w3CPFTNv0S+nIZ+D/B6jiiNTjnxSf5gzqrw2eH9gJeVph
	 Uh4aMeE6psyPGSVNY6AWbErQWt1ccXhE7BUY+zLmb/X/JVDz4tX0t2uoD/G0IhGfyf
	 bVL1doXmDXsxw==
Message-ID: <cb5d1253-6b52-4c77-9022-7f4e6e50377c@kernel.org>
Date: Fri, 22 Nov 2024 07:56:25 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2] MAINTAINERS: split kselftest entry into 'framework' and
 'all'
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, Tim.Bird@sony.com, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org
References: <20241115200912.1009680-1-kuba@kernel.org>
 <8192e307-b2b9-4c48-87e2-31073c084218@linuxfoundation.org>
 <20241118132324.3248c97d@kernel.org>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20241118132324.3248c97d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 14:23, Jakub Kicinski wrote:
> On Mon, 18 Nov 2024 14:02:29 -0700 Shuah Khan wrote:
>>> Sorry for the delay, the responses to v1 weren't super positive
>>> but I keep thinking this would be very useful :) Or at the very
>>> least I find workflows@ very useful and informative as a maintainer.
>>>
>>> Posting as an RFC because we need to create the new ML.
>> I have to repeat the same thing I said when you sent RFC v1
>> It is going to add the confusion - people don't cc the one
>> mailing list we have now.
>>
>> I am going to have to say no. Sorry.
> 
> To me the dissonance between your admission that people don't CC the
> current list (IOW status quo isn't great) and the resistance to change
> is fairly apparent. But it is obviously your call.
My thinking is that people don't seem to CC the one mailing list
we have and adding one more would add to the problem.

Are there other ways to solve the problem by using prefix like
we do now for subsystem tests: selftests:framework?

thanks,
-- Shuah

