Return-Path: <linux-kselftest+bounces-8880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE028B294D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 21:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E847B23028
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103B152533;
	Thu, 25 Apr 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkKA1cKA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43B152166
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075181; cv=none; b=XrBS83LGS7jTri8o38hDTYgA3xT03QRMDj9nnxGYq3DY03Crt9bamaH5m+QdNao8VN6XSxbLCIfgwHVkoDUbpkBDpV1ane01Vkx6VukjeIADPU8LiCoBQH+o9HpD/dL8qP1EX+1DHKM4qfKYTvSwbOOea4Np0zaiJZLFD1GuEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075181; c=relaxed/simple;
	bh=0rvsB1EywH9lMzyqqGRclLkfnfKLWSH3VAuu/tTeaZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZrnKd9hukVC6Bpl2kEanXimNZskRgZBG4BeDcTejbFYfgqz4vFW9Www07THZnERD7Qs+VPbV7wRf1XTPPXkjU6AOwkkuXgSRU06b2TaTqjgSEqhOvvJdYDpSYBwcn3BvVguFRb30wJo9mlWO0iny32+5iVjiBY9gaj0fGutiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkKA1cKA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714075179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+LRzQpo2wEWrfoGFtG/XZ51EhpMoHFQaxbJ8lYpJ9PA=;
	b=dkKA1cKAq6U8YiP6/CPoYXsqbl3U/tIhUZSaBuvMP3EY7dvwUctp7eNJ4cjEUNiAPKvZP8
	pJsIHz3eukkig2qxSc2nQd6GbVhWrwJ3Io8R44RytFBfY1y1k/2NtERv7MteXl50P14DOu
	XJBrmf1gKKuAX4eUiRVEzCRYlxsJeq8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-4AGjYgClMw2JrT6HPLtwJA-1; Thu,
 25 Apr 2024 15:58:33 -0400
X-MC-Unique: 4AGjYgClMw2JrT6HPLtwJA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBFC928EC104;
	Thu, 25 Apr 2024 19:58:32 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.33.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A83440F17B;
	Thu, 25 Apr 2024 19:58:32 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: selftests: openvswitch: Questions about possible enhancements
In-Reply-To: <20240424173000.21c12587@kernel.org> (Jakub Kicinski's message of
	"Wed, 24 Apr 2024 17:30:00 -0700")
References: <20240424164405.GN42092@kernel.org>
	<20240424173000.21c12587@kernel.org>
Date: Thu, 25 Apr 2024 15:58:32 -0400
Message-ID: <f7t1q6t9puf.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 24 Apr 2024 17:44:05 +0100 Simon Horman wrote:
>> I have recently been exercising the Open vSwitch kernel selftests,
>> using vng,
>
> Speaking of ovs tests, we currently don't run them in CI (and suffer
> related skips in pmtu.sh) because Amazon Linux doesn't have ovs
> packaged and building it looks pretty hard.
>
> Is there an easy way to build just the CLI tooling or get a pre-built
> package somewhere?

As Simon notes - we would need some support in the ovs-dpctl.py to set
up the tunnel interfaces, and probably need to set them up for lwt and
classic tunnels.

I have a test branch where I have support for the former, and I can
clean it up and submit it.

> Or perhaps you'd be willing to run the OvS tests and we can move 
> the part of pmtu.sh into OvS test dir?

I guess either would be fine, as long as they can get run.


