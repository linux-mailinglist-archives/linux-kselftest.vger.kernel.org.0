Return-Path: <linux-kselftest+bounces-42876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EDBBC5349
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDB224E9591
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D236284B3E;
	Wed,  8 Oct 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ccjXMZfI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F52848BA
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Oct 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930205; cv=none; b=m+n07VypQ3/aTJnO9uzsuGLK0HsC/kWeQov9stYunh4q4OzcDh1moer49svUhUnVm/Is/gkqZ6XsmMaghJ+tS7dBeEvfNXSzzo45GkbpMqVpU17C7JkrgcPWJIHQmaLRIgkZ1yVMKpwLVU7wJ9hUmW2lZYuQs1/At/sWdp3SKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930205; c=relaxed/simple;
	bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA0QKjbVHTEo+A3hmPW0eE+Y84BBwa5DpmMsRQ8R6mg+0Ix/EhrFpy40D76NNSwG/zAo5Y1A9lluXEZEO8SfnhD18CUrRhDhtu1yEC8lTlfl4G7iBSc+8L4ZTldGG5OSyLhm69FYcmTw9oneT/DqoeLqOfmA+TTuXP74chR0w2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ccjXMZfI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7a7d79839b2so5869383a34.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Oct 2025 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759930203; x=1760535003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
        b=ccjXMZfInHOs7xmwWMiYM+8Bs/DCsV722cefic0qXQ/Y5k0j0vKh5QF1dgsLbfJDnN
         EzLRzJm1YqCDEPIrlXeWAdFY8GbekmhRfm4/N6NUCEt2L/QrWSnOXKOYInI1xSECH0rC
         WrlC1opaE3NoXj3qSDFIj5HQfxBZargBI4Gm6Fd2DPq30v4LRH4vI/X9GnhTkn/mDbk1
         PnAOsaLOihakt/JcpghJyQcwJfZetiFNeM+umS8jWCuqf6wPwB1FknDrGTKjBnC+lwB3
         6vhX2F2WZcpUC8YsWrzFlLRSvbAubN4TQeQzg6xLCIhNMSLGgILS0J0Zh3A8RFykwf04
         qxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930203; x=1760535003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR+vWqku4LvXNZ2Kxr1BNaADTOJakXGWgH5KTQfQJiI=;
        b=ee/kqbPGlMf/2Yk0nA/JspY0dNminJxeoJ+HbKwJtp6OUybXT+CbNCeN9MWKhH3w/g
         RFWBb9d/LVSFNelGwYf++9jBg3vysgMxVNEvHUdy/cjhLjdt8aMY4/eTLWBe/XNsxqhF
         OvbByYrBsyxlzmUZ+ps119BlbTZEOCDizJSmVnw8Yg/UWP6ZQYqFFfju+ISlh7NnoKoS
         kU67yGzP9p0TkmgrmncjvTVBuejwCOJMbaWTh+v8aiVl7xjyRWfZSzb+52crY44W6GV7
         JaKYa/XuJ01AB+dKjPcMNn2fe+yvJSUP6LVFDT0sNe+n3OMD9zurhleUpf4x1Ogqsb0G
         4IWg==
X-Forwarded-Encrypted: i=1; AJvYcCWhy8BP04yvMLo+zkL5e7DPmrEhL1biKWVcXZr3y7FHoi0lK8tmuqg97CmZLx5Gi+DZsNRiIjGZ092Ze7SZazA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWxsioIJd9CJ8ID8jyDqS1aZH/4rCb7/mjRn7wrZdOWvcp0dB
	yRsiJmqer/VKYKfuRpTlOGTSdRbKGT4Whn5GRwLyZ8h/rrjmSz0HKIBcaOWVJVZOF3g=
X-Gm-Gg: ASbGnctYCJuQPpsU+LdYIbvNnzO1vJlHU+YlrUthTVQlKtOcqKshcIvvoWYJMjJog2m
	E/Ix4EOT/NEo3by22KJWV3/qN3qIfFc39q4gr6+wvNRqEPiJq+Uxetk7a+8nOh3zJcoRz/F2MkM
	cX+ZL/HKs0oRXPFVRr5jNvWmbC7xiMk4gR5A8xxAx8/jWNiv06bQrG+E51i5kaWfLC/w3igwr+R
	i0Q6XQGic0ELFf8X6cUJztAr1oV2U5wmFekt3S5KlMmNkpMOQ9E78cfpMXRegjhU2fvMug5rFWq
	lOAzooeZuK10j568JlFoa5dSQ9SqQ7Wpr6aiU3DWurpmcIbXrCl3o1MRb4I4ebXaTcJuy74sDAv
	EbuzMvWmpZppjKhd9EkpUbbZjX4ypCrct
X-Google-Smtp-Source: AGHT+IEHXHi1fX92viHn1FlNncpYH+JLVa8oK1Fr/RFGZjN8SkFmL54M+5MvXjcHKBsxQCY4yNEe0g==
X-Received: by 2002:a05:6808:5245:b0:438:338b:edb with SMTP id 5614622812f47-4417b2f8ac5mr1803574b6e.12.1759930202725;
        Wed, 08 Oct 2025 06:30:02 -0700 (PDT)
Received: from ziepe.ca ([140.209.225.78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcf749sm5768186a34.9.2025.10.08.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:30:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6UEy-0000000Fw7f-3aJ8;
	Wed, 08 Oct 2025 10:30:00 -0300
Date: Wed, 8 Oct 2025 10:30:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandrozanni.dev@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
Message-ID: <20251008133000.GB3734646@ziepe.ca>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
 <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
 <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>

On Wed, Oct 08, 2025 at 03:24:29PM +0200, Alessandro Zanni wrote:

> Let me know which version is preferable.

I already applied your fix for this, no need to resend

Jason

