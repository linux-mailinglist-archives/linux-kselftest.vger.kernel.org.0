Return-Path: <linux-kselftest+bounces-42082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB9B92A4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 20:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328C23A8A6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 18:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65931770B;
	Mon, 22 Sep 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMZMCUwR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2582E62C0
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566923; cv=none; b=sTq9Am8fPhSdClWR0zRZUOIT3ewCJ93GZanwRfDTKjgSvPJh6fqdjTpV5aJxFnNOQue54ThCNhKLWByKg6dJiwPU5y2yAII63imuYBwqcDlRey1MJWKzE9DNHr8rxY2yybW6s5WY7a3jdwMvntlc5gy1/IghCr3ezGLHer57ATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566923; c=relaxed/simple;
	bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7RyhGODTLWJxYGebZ69p2h0UoKuaqeVYS4cFh2Zk1CZVn0yJ7sHnN+Og+fKfyToIFcGEr8aR3H/FH4kKR+K4z5dxky8fRYcuRk84PxQLjMYJrzS0e9rI9ns6iqYJofs+TNAMLsswnwRDt98X33Ocqwsc+bRANvPDfcMvUpMLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMZMCUwR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7761b83fd01so4389412b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758566921; x=1759171721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=EMZMCUwRqkqCT7w8Zq8rDm4OrkZdVUjuWagkuWRFgsBEcR4H0ab3y255zQb8kv+8Ku
         mI6iIbZXgUt/HcTQtAXojjSmTFH5pEDAV/unjNJ1AQbxdtTAvt5gWZ0uF+8Qll98vd/v
         CUyzL9+3Z/ozswqE+LwhUbfGoUUkQLfUckDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758566921; x=1759171721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=KgxD6bnimQPztThr8C/LghZzyDx6k0BTlUf0jBF7sJlit1N3+dUyeI7QzRtDNV6Zk2
         zKjuiCRaHEqyOD3ZP0pGuSnD1UEtnQxslR0k2uTRVkXe4vb3NUT44JUtKJwW2Gw4PDvl
         I6dPEHOYliH1+YOj93QluT3klOhophRttbFegxF1QEKlm9rup3llg8+gc8dwIzgnOOqS
         W05EOza/C6VQEMNzvoTmrS6HBThwirmCA9k8vBf5DiJIpWNzXv5LH4v9LqQTWhFKGLdZ
         kRo/AD0nqoNDyHhzV8bp40rSpntOy5BC7O/F1g+VlRINdMWYLkJefw9P6PTje+vOa/QY
         LUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA1l5xdy8tx5sFiHbzaSnMlJ8ptI16CKGby+5R953NHHPShcjo+583w6A+mc6fX6QfEVOQWD+U7DU+dykb5jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoIqCsvEuqZO8nEe+No1g7hj6SdOeTUi+/yQZ3rpjTfKE2+7b
	/73xq26Yujo0t51sPd4BZEaWLA7Zo9/6q6HobyeLmIKuSdYnvcoUgLHNOL2d36wi5Q==
X-Gm-Gg: ASbGncsy3nKZR1bH8j33vdB0TaE6pKF+I/g8ln5AePRbqcAhqOUDoTF3BTY2Tg0RZFz
	ZT4Wwh+mCp/ls2joGz2dNatNDH35wmwS94uzKPDHMtMQVj8yxvjF2Xc7rikVgh5YwzNErwGCtKn
	TbNYBQmBuM4WHBYf+Jfg5MDdclroZ5Zk5cG5lSA6Cq4L0vDksJeOlwKcqyr7p94iWdsVN2JPxxp
	5uFAm9yrnlCHUQCRtGCX6KuUynQ7w2M0kI+H9v24k5jV44hcTWskYfz1aDorMwmSy0Yip3tQHC7
	+mB4GiVKRWNJDKhKcEAfS+6u82wSNSMAHkWSG8xPN4II289v92hbVXGUIVbbNeyuzgPnH9Xfy0y
	G8VF8NEztOczQF84HSRklt4DvOILoVKwBCew0Fqj78rqZPKEY6pmFP1Oj+4pV
X-Google-Smtp-Source: AGHT+IEwQZB9OJP+yIk47lHkNRnpblDU+mAiC3pniWHHE9+nReBcI884SHHQG9F+tJn/QrVZqfu7fA==
X-Received: by 2002:a05:6a00:390b:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-77e4cd35838mr16708833b3a.4.1758566921098;
        Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77f34d416a9sm4169794b3a.101.2025.09.22.11.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 11:48:40 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:48:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aNGaBiUOb6_n8w8P@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGR0x185VGHxSde@infradead.org>

On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> Controller drivers are a special case I guess, but I'd rather still
> not open it up to any random driver.

I don't really see why this particular thing should develop restrictions
beyond "can it work in modules?", but if you have an idea for how to do
that reasonably, my ears are open.

> When did we allow modular
> controller drivers anyway?

An approximate count:

$ git grep tristate ./drivers/pci/controller/ | wc -l
39

There's been a steady trickle of module-related changes over the years.
And several modular controller drivers predate the
drivers/pci/controller/ creation in 2018 at commit 6e0832fa432e ("PCI:
Collect all native drivers under drivers/pci/controller/").

> That feels like a somewhat bad idea, too.

Any particular reason behind that feeling? Most other bus frameworks I'm
familiar with support modular drivers.

Brian

