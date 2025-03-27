Return-Path: <linux-kselftest+bounces-29847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55690A7282E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 02:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2088F1895723
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 01:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855C450F2;
	Thu, 27 Mar 2025 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Niggnuu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A44224D6
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743039544; cv=none; b=efQGS1PCMatBTumG+7/vI1cZbGmYTjfA7l9kETymdsnZFZjXkmi432B30zpQNiIKeJx6qO/gN5LMiWMXxJdZGEkFDvF5eQ5yhVTYTzx+lUV3Ph6VK86dV7/8UvBqXrYmmIMCs2P4vs2x2wCZGqKHeWrd8NdF89b8QW28jQ7J/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743039544; c=relaxed/simple;
	bh=QGxIkAL7OSoVA8BAc9zFl3PBXP8AEu42BSiBhdQi+Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAVJWiH+t+W1lQhV/6VeoMtc1qqlsFx61Kw3l+26jwjBMCH2D6cIFJDNAsbrBiX/nhTj/eoBD35gq+Z7hNeI1BQ3mrkZvoXqs5JPAPVotHRx0jnP92sfc1A5CchKlFC5Kq/UbsEMXNiKsBe7LS+dCrqN3KXQ35p5SxGmyGPzuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Niggnuu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743039541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yi3Cvs2AMKrlYyTdrtXM8SZfyviMQ6+kbZC7tqULxT4=;
	b=Niggnuu52Tyace0up1DeHjsSqBV7y8QpVLNt4mDIIuFCHau9Dr6aoBTlTGUhdZSkswhE8S
	VCVO1tlrXANgOipa1IKWe3qotWAQYZf60iKtUBMc0nJjswW4xdps9xnUIWIwcIEL1thFbw
	xnY67P0J0vvRH3cupfHShSN7NU+I+xU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-x3gIikrSNmKloqJBdCqv_A-1; Wed,
 26 Mar 2025 21:38:58 -0400
X-MC-Unique: x3gIikrSNmKloqJBdCqv_A-1
X-Mimecast-MFC-AGG-ID: x3gIikrSNmKloqJBdCqv_A_1743039537
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7680A190308B;
	Thu, 27 Mar 2025 01:38:56 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DCE8180B493;
	Thu, 27 Mar 2025 01:38:50 +0000 (UTC)
Date: Thu, 27 Mar 2025 09:38:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z-SsJEvKkqakMwVA@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
 <Z+RN+CPnWO69aJD5@dev-ushankar.dev.purestorage.com>
 <Z+SI4x+0J52rCJpN@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+SI4x+0J52rCJpN@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Mar 26, 2025 at 05:08:19PM -0600, Uday Shankar wrote:
> On Wed, Mar 26, 2025 at 12:56:56PM -0600, Uday Shankar wrote:
> > On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > > > ublk_abort_requests() should be called only in case of queue dying,
> > > > since ublk server may open & close the char device multiple times.
> > > 
> > > Sure that is technically possible, however is any real ublk server doing
> > > this? Seems like a strange thing to do, and seems reasonable for the
> > > driver to transition the device to the nosrv state (dead or recovery,
> > > depending on flags) when the char device is closed, since in this case,
> > > no one can be handling I/O anymore.
> > 
> > I see ublksrv itself is doing this :(
> > 
> > /* Wait until ublk device is setup by udev */
> > static void ublksrv_check_dev(const struct ublksrv_ctrl_dev_info *info)
> > {
> > 	unsigned int max_time = 1000000, wait = 0;
> > 	char buf[64];
> > 
> > 	snprintf(buf, 64, "%s%d", "/dev/ublkc", info->dev_id);
> > 
> > 	while (wait < max_time) {
> > 		int fd = open(buf, O_RDWR);
> > 
> > 		if (fd > 0) {
> > 			close(fd);
> > 			break;
> > 		}
> > 
> > 		usleep(100000);
> > 		wait += 100000;
> > 	}
> > }
> > 
> > This seems related to some failures in ublksrv tests
> 
> Actually this is the only issue I'm seeing - after patching this up in
> ublksrv, make T=generic test appears to pass - I don't see any logs
> indicating failures, and no kernel panics.

Yes, that is one example.

Your patch breaks any application which opens ublk char more than one
times. And it is usually one common practice to allow device to be opened
multiple times.

Maybe one utility opens the char device unexpected, systemd usually open &
read block device, not sure if it opens char device.

I try to add change against your patch to abort requests only in ->release()
when queue becomes dying, and the added check triggers kernel panic.

> 
> So the question is, does this patch break existing ublk servers? It does

It should break any application which depends on libublksrv

> break ublksrv as shown above, but I think one could argue that the above
> code is just testing for file existence, and it's a bit weird to do that
> by opening and closing the file (especially given that it's a device
> special file). It can be patched to just use access or something
> instead.

Even though libublksrv is the only one which has such usage, it is
impossible to force the user to upgrade the library, but user still may
upgrade to the latest kernel...


Thanks,
Ming


