Return-Path: <linux-kselftest+bounces-8432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F38AB042
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EF01F2116A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C47E136E0F;
	Fri, 19 Apr 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VS9F9Aml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9A136E03;
	Fri, 19 Apr 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535450; cv=none; b=EcS9v+VG7ice2YGff84c9ex+6o0Eeq2XWMUWjHuzS0wWkU2CfFQUoD1kvk7pzwIBzblu4JuURwT5yb5tqF1vAHoe1FXl2AKxN6Txel4TEvgNL82UymU3mA9yKQmXVMcAqRRIk9Ei3NiO4vYqWJmqGGQB+5a35sZ4WrUpj1HsFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535450; c=relaxed/simple;
	bh=zd4B2k2WaVQRixz1Zz7N9Fik5Yjb6pyjzhJ5NlvMHZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDHmyTfMCCAODVPFXbQnoM1mPYcCUBW26jhdB8I1qjXt+t5hhFjS//wmUsvhBlCM4VJOru0Dm3W6uaL5+t0ls3XSulQdvV5YwRPOstqPvY7iz8CcDsS7A2o7ZKQYaG+V8OYR+8ovI/QYOimiG6SF530l2K/WJaSX5WTTS4ln7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VS9F9Aml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F1DC32781;
	Fri, 19 Apr 2024 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713535449;
	bh=zd4B2k2WaVQRixz1Zz7N9Fik5Yjb6pyjzhJ5NlvMHZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VS9F9AmlyXURr86YUdWYb7QN54sEF+o9/HopbQ4zfMb5YwPOAncRA6X6L4yQm8A2j
	 9YHZPcyknj2LuFKdbF4qqLu9FEW9kN2n9SX1EBn6ftAmfEWi3Z+C7xmjhUWcE3iye3
	 okShGGuMa+cG/4TfFhmZOH93RJzKObNz8g7O1dPQ=
Date: Fri, 19 Apr 2024 16:04:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>,
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] kunit: unregister the device on error
Message-ID: <2024041955-strangely-snack-b335@gregkh>
References: <20240419132504.9488-1-wander@redhat.com>
 <20240419132504.9488-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419132504.9488-2-wander@redhat.com>

On Fri, Apr 19, 2024 at 10:25:01AM -0300, Wander Lairson Costa wrote:
> kunit_init_device() should unregister the device on bus register error,
> but mistakenly it tries to unregister the bus.
> 
> Unregister the device instead of the bus.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

