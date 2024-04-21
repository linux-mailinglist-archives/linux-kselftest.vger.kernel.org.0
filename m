Return-Path: <linux-kselftest+bounces-8562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8C8ABDE2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 02:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E8DB20D96
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 00:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED117E9;
	Sun, 21 Apr 2024 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxmsC5KC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE745645;
	Sun, 21 Apr 2024 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661148; cv=none; b=et86LCoZe91TGxAMIDtg4X0QaH4Bvhj1a4+tN/H3jHaE9Z7qBojCP/9SopmVyzB4XdTumu4+x7yiCvr3YCee7hfcqpR6zEwfCRQ9DjFRk5gyPFf+Z+7cILJvpptL0hbCwgVu5LIEQdZ3cs8iHcYlv96FUtHzBVqVd3mm5YlAAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661148; c=relaxed/simple;
	bh=k3HxexRyAK54ZfseqCiM9sClS8OeExGwRr8NllE6PEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOb2F9tHO60wXJTDbaL0j9XE3MNBq1kfpWdpqvmXIMh+7r4YxRrAwrXQG4ReFyvlMTVqTIRFvpirIsfE3QT/zztx/cwGHexoLJwQC/Wm9nBHTtFcV7WBysbLrRvk6Mxraw3WuSO1zD6Nd3HU53+X6kYKe1QeRMM2MoXS+pKcuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxmsC5KC; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36bff60429cso7685715ab.2;
        Sat, 20 Apr 2024 17:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713661146; x=1714265946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W868qMjJ3/Z4vhCYEMuyN80hK7vH/XiqaqifXCQSkQI=;
        b=OxmsC5KCpd1R7LnBl1BO0KBAcJWGa1sSRGD4AME8+NleeKwExxeUxP/pR8C2mu9Xhw
         FhHF0zR/0ywrFb5OYN8FfX+SF6UmjV/ppkURY0QkAT/jYkhc0DJzH/cGqtZUHblabiGc
         w1h/cs8jwtT5wvDrIlAHF7JGnDOCdv3doLs2tOJzn/LfjCgE2GOQWpupYDVWGXXj/4eX
         intJQqi6vDC5FKjmWE4p1ezFVSvfMH44mNOFtaYGugZYExoR6oaizBxhCIOkUvar/+Ex
         ZsA3WzkBzn4pasml6ypVm3SDUtkmPAErrJm1caTSMQJcVGTiFY0lfQeUMN7cFtw8ibTi
         0Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661146; x=1714265946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W868qMjJ3/Z4vhCYEMuyN80hK7vH/XiqaqifXCQSkQI=;
        b=rwAusf5B617aH1gCJXDPIwLbW2mzwRI0XQsHdz2cBh8vP/B0dR0NwqX2FHa+Go/EWs
         xT4sOFiKvUlg0YjST3oXVEBwrQIW3Tk/hZn4VYubpb4wpBXs9HSKc+DbF804uCzsB6bm
         WOPcESUHwiUsk8yJMQHVIzo+VM39XuxsS2sSzoKz4YvYoNNWonZ1y0wO76OVQ/ZpJxoE
         7sIF5MZW373fWl/X0TF4Xnyy0oIgGSZAwG57jhmExh29X/kC5hFIrTEmBzhRcPt1qM79
         LH9Pbj57SOqI6LK1QvAqqTK/7eW64xn4j6KPCBCWL4xAd0mSRmi6qIjkjRIvJVzY6gVi
         V0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1AdSxXjc8s0CgYq2yfUVXdyDWA7Hyr3+nslobzCzPFHDNA8yUxRHbJxIt7K436LW51LsE9SBG6mN7j/X6gd+14OoU2Waaac+kZf+Zypo
X-Gm-Message-State: AOJu0YwhgUBPM9zMcgwfOaJcwKruPI0p1pw8szeL2DxXYFdgTPzmAT/o
	4rEOXlpt+n8yBArEdEUwFwtip2LZJy4R089AzauPNTl7asVoXgTL
X-Google-Smtp-Source: AGHT+IG05j29gmU72G7Nff/+V2iSS5BBODrpBkB8jSGdCjvac648eVhmaPmfrjvNL0qmLDT6L8XrHg==
X-Received: by 2002:a05:6e02:1fe9:b0:36b:3952:c1ad with SMTP id dt9-20020a056e021fe900b0036b3952c1admr8319997ilb.18.1713661145821;
        Sat, 20 Apr 2024 17:59:05 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:1518:4e26:8dc5:c7f9? ([2601:282:1e82:2350:1518:4e26:8dc5:c7f9])
        by smtp.googlemail.com with ESMTPSA id p6-20020a92d286000000b003687fe513f2sm1416458ilp.2.2024.04.20.17.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 17:59:05 -0700 (PDT)
Message-ID: <87cb71ce-07ee-4d42-a61d-f37a7d6bf2c0@gmail.com>
Date: Sat, 20 Apr 2024 18:59:04 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] netlink: move extack writing helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, amritha.nambiar@intel.com,
 linux-kselftest@vger.kernel.org
References: <20240420023543.3300306-1-kuba@kernel.org>
 <20240420023543.3300306-3-kuba@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240420023543.3300306-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/24 8:35 PM, Jakub Kicinski wrote:
> Next change will need them in netlink_dump_done(), pure move.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/netlink/af_netlink.c | 126 +++++++++++++++++++--------------------
>  1 file changed, 63 insertions(+), 63 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



