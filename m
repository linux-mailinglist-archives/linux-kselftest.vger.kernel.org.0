Return-Path: <linux-kselftest+bounces-3373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED0837583
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9299289D09
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B34E47F66;
	Mon, 22 Jan 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HFhIroaL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA9048780
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959448; cv=none; b=C2Vzxntv1mL7MHZzYUCcYIJZuEb6kHZfB9LxIwjAkcgy0lN7hhd6UU8hvm0Tj16l9VwRmZeeiMQ6mQtIqMiGP50lEm9DlKyePHhFtlkxkZWtsTpoRwSUtPk4qjc4pADhyvRXgN6BmzZpuhVcSKzw/wEdZl3Ura2G5pqdLAag3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959448; c=relaxed/simple;
	bh=5/pQLkcUiTNBJ4GWoxa48qJz8BKfFyRtcf11jSHyWm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU1efF3ku22YeqcT2XkLLqVj+LGlco+HblLTJfldVkVlbifdSMxiHo/j8ZROdtQrjbWGbl19Z8DHHW0+mSlq9aJ93WVt12TA+fiI2DBuP1NzBWOzyynrpznaFj2srCJE0VFz1qghCtvtWPnHkyXuOXO/U9dp4DmewmWV/m8p9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HFhIroaL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbe5014eb5so815409b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959446; x=1706564246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqU+NpYqpqdwKjXYi9GIK+LK6032K0kbkQ16WNlrD6w=;
        b=HFhIroaLSNyTV6TGCjVJ1CQmeB5IQeJ8zWcD1bmarkbaTKwA2JS4SwiHnirUx0+AJU
         rHzjgx3g+ae7lIWC6fFIl/Svnnz3qhVEv8zk+L58C6uaP7KHwrmvCo+mChDQ7FCiylft
         gkkcFHnCsqNRODy5K6PU1fCpPqdlGtFT+CiGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959446; x=1706564246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqU+NpYqpqdwKjXYi9GIK+LK6032K0kbkQ16WNlrD6w=;
        b=AT2+/Q6xrFGMBaZqUjgfnOlK6IHHjErd9cV8/h/R/fNvGHEaVxxucl4UDqp+nEzRLe
         i8XUerbxw3yQ9if3Yd638Yd92LoRHBD1woATcu3W/4IDNeQILB9HV+GCuyAH6NieNvFt
         Prld0N2nTGeqk28Vdlli9Zh4yUtgWUUq5L9V4r156vS6b/ejQnPNJq4bfrSviFyy4T3c
         HX7UFpLLufF69KQoI2tFD+C0bDbfZT3p/HcG55nawlkjhvaNuTaBj1lQ1CTy23V/OefP
         QrN2aLKf+OEL0JqO/GhiNuMMKHN0hf7q0Ch856y2E8VMUxNg9pPQ0zgMXZ5fn9ByGXo8
         8HMQ==
X-Gm-Message-State: AOJu0YwbQ/I59k13ZnvB9lcbEtYA6H8vJXSIMoHcqYYzG6fCM29R1blE
	qaenn0+jq7oTqu4qeKtySu/1Fn62J4UU3RrfKxK9eqj5THnatLIkkViQB9cow7hjX6obqKkPacQ
	=
X-Google-Smtp-Source: AGHT+IEi1NvVtuUCmjQ+rFLTn7yJXNqRcixul6vWlnAcFfcqDRQ3ktvUcexwz+OaKOAHX9u00mffIQ==
X-Received: by 2002:a17:902:d3d3:b0:1d7:199:cfc5 with SMTP id w19-20020a170902d3d300b001d70199cfc5mr2357522plb.117.1705959446562;
        Mon, 22 Jan 2024 13:37:26 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006d96d034befsm10119695pfu.30.2024.01.22.13.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:37:26 -0800 (PST)
Date: Mon, 22 Jan 2024 13:37:25 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v3 2/2] kselftest/seccomp: Report each expectation we
 assert as a KTAP test
Message-ID: <202401221337.29DA621DC@keescook>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-2-785bff4c04fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v3-2-785bff4c04fd@kernel.org>

On Mon, Jan 22, 2024 at 09:08:18PM +0000, Mark Brown wrote:
> The seccomp benchmark test makes a number of checks on the performance it
> measures and logs them to the output but does so in a custom format which
> none of the automated test runners understand meaning that the chances that
> anyone is paying attention are slim. Let's additionally log each result in
> KTAP format so that automated systems parsing the test output will see each
> comparison as a test case. The original logs are left in place since they
> provide the actual numbers for analysis.
> 
> As part of this rework the flow for the main program so that when we skip
> tests we still log all the tests we skip, this is because the standard KTAP
> headers and footers include counts of the number of expected and run tests.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

