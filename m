Return-Path: <linux-kselftest+bounces-26931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627FA3B0C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 06:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39FF17484E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 05:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9781B0F35;
	Wed, 19 Feb 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/cei//h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC01A9B27;
	Wed, 19 Feb 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941750; cv=none; b=YP83wG92TcXUvO4E+EjB2NxJFn5LonjIhjkJFRSqiUL4z9LEiMcnODd5L6/XTY98bsM4bQ9ThbAdMKo6qWY6/DiDBDC2tGPEVWjtw1iDwIGwzekli2iNujSt4wqyUqJW2hA3+h/T3dVJNNxTwZzeKFsYRQ0vNX53qlIr2uP8c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941750; c=relaxed/simple;
	bh=6h8ecIB9RE8NEbkQcevOEnAlX8Vq8sQghBewctetbT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFK6MVVFuuFmBHNqJTqxGPUCV8fpBjjqrsztBwBYL7Wwm+UVyMhZcyifkDxOCuh93tPtYGIlSJ7VZmUyZTNJ4JOTzyy/mmO/900uwzVf8JeU6+ohxq7WYKICWQSCUOpEAX2asnO7bCT8UCQgDfS6VmB/N+ij6Cn6NKRKA83MUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/cei//h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F9BC4CED1;
	Wed, 19 Feb 2025 05:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739941749;
	bh=6h8ecIB9RE8NEbkQcevOEnAlX8Vq8sQghBewctetbT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1/cei//hPMxHqiGfMQsCIA1WAdFeWmLId42G5QRlkcGD06Wu3GP4q5F8IwWrX/K14
	 4Ih+EFNXu2kpfU7tGWjzWXBgk5pyRkbuRxxuujV9lT0FQNyLkR94UQIYRGKHygdkBs
	 jfOXdgQJakaJtw2enzxTVPTd5pmOsNbj4VaOaFDg=
Date: Wed, 19 Feb 2025 06:09:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yifei Liu <yifei.l.liu@oracle.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Message-ID: <2025021935-blandness-celibacy-5fea@gregkh>
References: <20250204214723.1991309-1-yifei.l.liu@oracle.com>
 <2025020544-preview-worshiper-8539@gregkh>
 <C8A5840D-B312-40DC-A75D-3BA14614F8C4@oracle.com>
 <2025021143-limes-babble-e137@gregkh>
 <1D84255C-D49A-4056-9299-B1E6099154DE@oracle.com>
 <4FF4FFA8-1385-452D-9B44-D791B664D4E8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4FF4FFA8-1385-452D-9B44-D791B664D4E8@oracle.com>

On Wed, Feb 19, 2025 at 02:13:29AM +0000, Yifei Liu wrote:
> 
> 
> > On Feb 11, 2025, at 4:33 PM, Yifei Liu <yifei.l.liu@oracle.com> wrote:
> > 
> > 
> > 
> >> On Feb 10, 2025, at 10:24 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> 
> >> A: https://urldefense.com/v3/__http://en.wikipedia.org/wiki/Top_post__;!!ACWV5N9M2RV99hQ!I6O0EcBYMun5zy7pK39ZG9aJYrbv3Uy7IaJYl-fKOXJfmImBbzfXDFfOWeYY2o1JutHPBoAoI_b7xJQyjQ5nnfgv$ 
> >> Q: Were do I find info about this thing called top-posting?
> >> A: Because it messes up the order in which people normally read text.
> >> Q: Why is top-posting such a bad thing?
> >> A: Top-posting.
> >> Q: What is the most annoying thing in e-mail?
> >> 
> >> A: No.
> >> Q: Should I include quotations after my reply?
> >> 
> > Hi Greg,
> > Sorry for the top-posting. I will not do that any more. 
> >> https://urldefense.com/v3/__http://daringfireball.net/2007/07/on_top__;!!ACWV5N9M2RV99hQ!I6O0EcBYMun5zy7pK39ZG9aJYrbv3Uy7IaJYl-fKOXJfmImBbzfXDFfOWeYY2o1JutHPBoAoI_b7xJQyjanSNOhz$
> >> 
> >> On Mon, Feb 10, 2025 at 06:43:49PM +0000, Yifei Liu wrote:
> >>> Hi Greg, 
> >>> Yes, looks we only need this for linux-6.12.y. Maybe we could use the v1 version which does not include the linux-6.13.y tag. Or I can send a v3 with the linux-6.12.y only.
> >> 
> >> As you know, we can't take patches for only older kernels and not newer
> >> ones.  Please submit them for all relevant branches, AND test your
> >> patches before you submit them so that they don't fail on our side, as
> >> that just wastes our energy :(
> > For this patch, I believe it failed to apply to linux-6.13 due to another same patch applied before it. Commit d9eb5a1e76f5 ("selftests/mm: build with -O2”) goes into linux-6.13 with tag v6.13.2, last week’s tag. I checked the queue-6.12 and do not see this patch yet for v6.12. I think we still need this for v6.12. About the patch, it fixes a build issue for selftest/mm, which is bacported to v6.12. Thus this patch should only be backported to v6.12.
> > 
> > I tested it on my device and it works fine and solved the failure of selftest.
> > 
> Hi Greg, 
> 
> I checked the v6.12.16 tag released last Friday. It does not contain this patch. It looks we will not see the same situation we have for v6.13 like I mentioned above and it’s safe to include this in v6.12. 

I don't know what "this patch" is here, sorry, I have no context.

> I could resend a v3 with all the linux-6.13.y tags removed if you want. 

Whatever needs to be applied, yes, please resend it properly.

thanks,

greg k-h

