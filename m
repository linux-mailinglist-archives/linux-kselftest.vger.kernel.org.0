Return-Path: <linux-kselftest+bounces-47599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A5CC1EC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 11:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 355A5302C5FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2173336ED4;
	Tue, 16 Dec 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3JOCTE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7F3346B1
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880129; cv=none; b=u4QtrKOXThKNA1Zu6Y5HLRDQ9na05wNJXD8+zhQtym1MAPFDd6JYMBJtEkRDa6ru49T/vxqRNj2coX0CH+nhmwIYjv+pf/iFVFhF5blSvmStNvr2PU7awe4xnHl9Y2SYmexZsBhiCbArusvld3B91vieyHWQq2onFAghaIJ8hLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880129; c=relaxed/simple;
	bh=cA2hUBGWGe7TtiYJoouOp5tOunrd6L/AfwtK5Ym9Ceg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRJ85niiYannUxZlZM7qrnYn5W3SrABGjPyRNFbCcjeavBHyfexKwX+oNl7jdvGZpsnXGFRnFCjwpHwvmk0fzeXPBDayuSQnt98kbScv4weVdZLeKiCSyYPr8B7vVICEPztzJsfkephZqIxRVLAa1IoWkJd/ftKRqELihNW7F9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3JOCTE0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765880126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h471FGNIc2IuNt6ZxKT5WLDjfkpWMH0oarvYV9MqPK4=;
	b=M3JOCTE096zpHR/xEhTQ7JLnvQsU8BZL96pE6ADc2cRBSEUoEwZIqUtoUoat/5J43XPvtb
	9YiZv6rRNtrRMPa96My4+wfIMIHsc8iVfL0BpNLsY0p8tdGQmYH25nM5YCvkEdenfwFj/z
	f/k3C5bmSw9aeqwCOcYkEF4OYkflSpI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-Ell0bgi6PZeWBVsbc6N4Ng-1; Tue,
 16 Dec 2025 05:15:22 -0500
X-MC-Unique: Ell0bgi6PZeWBVsbc6N4Ng-1
X-Mimecast-MFC-AGG-ID: Ell0bgi6PZeWBVsbc6N4Ng_1765880120
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC9F18002C9;
	Tue, 16 Dec 2025 10:15:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 397511956056;
	Tue, 16 Dec 2025 10:15:15 +0000 (UTC)
Date: Tue, 16 Dec 2025 18:15:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Clint George <clintbgeorge@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev, khalid@kernel.org
Subject: Re: [PATCH] kselftest/kublk: include message in _Static_assert for
 C11 compatibility
Message-ID: <aUExL6cvFqpgx52G@fedora>
References: <20251215085022.7642-1-clintbgeorge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215085022.7642-1-clintbgeorge@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Dec 15, 2025 at 02:20:22PM +0530, Clint George wrote:
> Add descriptive message in the _Static_assert to comply with the C11
> standard requirement to prevent compiler from throwing out error. The
> compiler throws an error when _Static_assert is used without a message as
> that is a C23 extension.
> 
> Signed-off-by: Clint George <clintbgeorge@gmail.com>
> ---
> 
> [] Testing:
> The diff between before and after of running the kselftest test of the
> module shows no regression on system with x86 architecture

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming


