Return-Path: <linux-kselftest+bounces-3130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262A82FF3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 04:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3E61F235E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C9910F5;
	Wed, 17 Jan 2024 03:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmLqAxmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540791864;
	Wed, 17 Jan 2024 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461358; cv=none; b=Lz2k0PKZelALNLv5PSOizWnS2wjSkx+EsvMDis/XI1nUZjVc8kEXJ0S44n2Vvs71br5BRZMOv3GFrdTuCKZeEDzB72pxjgB/zORX8hM11dVWE/BnQaNwsdxMF9pEcUmC1A2NAz4UCtXyJVHdGSO17Z/Y6mJmE+xxwv74o6iumD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461358; c=relaxed/simple;
	bh=5FgcvGln3c6YqrWy1tAyXzm3PWkvGIVj3zICMxgXBIs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DPpRUP227uSjRKJu1lgMMjWkWe7RGrF9fJfZnpFAsdeVfR2qmWpvOyRii+M/GQGd57pUk4maMZWJXUF5GAwtvTmZTAU2X/OvIX1s8F18p6eqJW7tCtKzE/tb5pDJys9jaUN4/pfw8wp0UmShrQEms/xUEaM/lgtizrY9nIMG7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmLqAxmY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28ff31d0e82so232965a91.1;
        Tue, 16 Jan 2024 19:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461356; x=1706066156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9/Hk1LwdryZJj2DltvI7Pv1hcCf5hVBvpgQhGnzrU0=;
        b=fmLqAxmYPqDenVQjjcq4k3EomgHQzb6kQzxvVmDXVsRgaw3P5t3/oAFl5GFxMlaBXn
         uu52bNRCXEADXMIbVgUhWp7CjjSEsEJHJwnVq4GwIpEUoeDSbqcNbJPcwYDHfjgqXuN5
         v4kCM1uAOY6aLIcc0RJ3Q99khA3Y4+J307M8qAFmIUXoVA80CFOLPFAeKeTr4pYnAj2J
         fuu0H8W0JbR75GI/giBFgPoNW8QnQ+czdKHw4HhdC5bayZpqC9jLwYzqZU5VzXvuzHm/
         RCzKkw6Rw6WnX1XwkyIspAfA8cOH3DiJWVAqrMyiOBTyCFxwauL1t8EMhdOYh9TunERd
         cFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461356; x=1706066156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9/Hk1LwdryZJj2DltvI7Pv1hcCf5hVBvpgQhGnzrU0=;
        b=wzgQyHoMiQaFzWTg6KxyhOwfVAjchD7O+bc/NYZfQc3oDmyj8f3jiRwT3n9QRvcD6f
         ZbnoieKRC4WbeLE6yE5nlTVZsMXWEgGJtrxldrZQgneLUBiQGIxKRBMl2ujTsccav1/I
         3gKviv/jQO7SGU4UaV1W4H/wrni6ZHbdAe3YLhaDMF8Xup912OlIH0rTwlbE+vhTzqwJ
         qsiAw8p31iW9MSuuc0697D3qw4oyKam0BdqjCeM6Ho7z4eVcL6P+GWu3sAmzGJtGK+xk
         OCXp4rYK4A6vuJZYjBo2+hkxmdEqNCBNRg1fxvFbV+e2xEeqC2uVfUXyP/VL1G8FfP4n
         ZcAg==
X-Gm-Message-State: AOJu0YziqeEptoVXYobEFf8po8h5A7xjapgCXn8QQr0XvlzcNCBQUcKD
	vjw6yuSl7WNeWZAuO5yxaLQ=
X-Google-Smtp-Source: AGHT+IHjr96vxNXsZ5iaVvlRTVGnZ8lRNcv1e7sAyULIVhcG+535NMeUUFgn4iVwnG1W3Rxcm3DI3A==
X-Received: by 2002:a17:90a:49cf:b0:28e:7b66:73e4 with SMTP id l15-20020a17090a49cf00b0028e7b6673e4mr1392698pjm.5.1705461356570;
        Tue, 16 Jan 2024 19:15:56 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ee11-20020a17090afc4b00b0028db1713cbbsm15249745pjb.1.2024.01.16.19.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:15:54 -0800 (PST)
Date: Wed, 17 Jan 2024 11:15:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jay.vosburgh@canonical.com>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
Message-ID: <ZadGZeJOc26LOJJa@Laptop-X1>
References: <20240116154926.202164-1-bpoirier@nvidia.com>
 <20240116104402.1203850a@kernel.org>
 <78106.1705431810@vermin>
 <20240116112012.026e44d9@kernel.org>
 <ZabXT2ZepMuinE50@d3>
 <20240116112926.541e0651@kernel.org>
 <ZabdYhBRHiNt-jGy@d3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabdYhBRHiNt-jGy@d3>

On Tue, Jan 16, 2024 at 02:47:46PM -0500, Benjamin Poirier wrote:
> On 2024-01-16 11:29 -0800, Jakub Kicinski wrote:
> > On Tue, 16 Jan 2024 14:21:51 -0500 Benjamin Poirier wrote:
> > > real    13m35.065s
> > > user    0m1.657s
> > > sys     0m27.918s
> > > 
> > > The test is not cpu bound; as Jay pointed out, it spends most of its
> > > time sleeping.
> > 
> > Ugh, so it does multiple iterations of 118 sec?
> 
> There are other test functions in the script which include a lot of
> sleeping.

The arp_validate_test need to check the mii_status, which sleep too much time.
Maybe we can use busywait to save more time.

> 
> > Could you send a patch to bump the timeout to 900 or 1200 in this case?
> 
> Sure but I'd like to give a chance for Hangbin to reply first. Would the
> test be just as good if it was shortened by removing some cases or
> reducing the time intervals? Or is increasing the timeout the best
> approach?

The purpose of grat_arp is testing commit 9949e2efb54e ("bonding: fix
send_peer_notif overflow"). As the send_peer_notif was defined to u8,
to overflow it, we need to

send_peer_notif = num_peer_notif * peer_notif_delay = num_grat_arp * peer_notify_delay / miimon > 255
  (kernel)           (kernel parameter)                   (user parameter)

e.g. 30 (num_grat_arp) * 1000 (peer_notify_delay) / 100 (miimon) > 255.

Which need 30s to complete sending garp messages. To save the testing time,
the only way is reduce the miimon number. Something like
30 (num_grat_arp) * 500 (peer_notify_delay) / 50 (miimon) > 255.

To save more time, we can remove the 50 num_grat_arp testing. The patch would
like

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_options.sh b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
index c54d1697f439..20c4d862c436 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_options.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_options.sh
@@ -277,7 +277,7 @@ garp_test()
        ip -n ${s_ns} link set ${active_slave} down

        exp_num=$(echo "${param}" | cut -f6 -d ' ')
-       sleep $((exp_num + 2))
+       sleep $((exp_num / 2 + 2))

        active_slave=$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].linkinfo.info_data.active_slave")

@@ -296,8 +296,8 @@ garp_test()
 num_grat_arp()
 {
        local val
-       for val in 10 20 30 50; do
-               garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_delay 1000"
+       for val in 10 20 30; do
+               garp_test "mode active-backup miimon 50 num_grat_arp $val peer_notify_delay 500"
                log_test "num_grat_arp" "active-backup miimon num_grat_arp $val"
        done
 }

With this we can save 100s.

Thanks
Hangbin

