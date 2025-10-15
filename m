Return-Path: <linux-kselftest+bounces-43200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA61EBDEACA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCBC3A89E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8F32779B;
	Wed, 15 Oct 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JOI0xuUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65391306B38
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533895; cv=none; b=pHGmn1I771dbUMDZC62tOQKhxmvopXx6tKDj2o3HnMAUChQ6fMfU219q0gj3DAaiwbuFI4vb+Di38QI3r5paWupDSP3Vr+wS5oJJd+3QpVpzbjUTmAul0rQvBcPnkI7YSpFyn6G+HyS9rVMJ7qOOvbrRavuNbe956/s+PvWsXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533895; c=relaxed/simple;
	bh=TNN71mayoTkmy8rd0PDSJ9nlu4EsONjvOe6eFy+t5ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnk4dJ2/U6fof+ZXd0CZ4x48vUlzdVtcq6vHepGQkHQegLaaHb/7gVNs/aHU0d8haZRCpwhWpN/1ZuUKEGp7oYcnP4RQFA7qAk0gOYkz77LFyIU1d7ZpO7sZyCg/Axpb4scueeVJqayG8FKqoX9FCJbz/IQW180cdCGHwVWcYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JOI0xuUD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47108104bcbso3898305e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760533891; x=1761138691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSEXKmipGPjNX9UpQ1OcPNXCLJIBowGxqHQC/E69W1E=;
        b=JOI0xuUD0xScKu7yRljROe3KNMgEatUh2Robg4Dg2gAddZtwlzJaa96bdV/ZCZkVap
         oR5ie552WvYnBhRPG7LhHZm2gPgSYCKcWvPQH8A5SuRFJ5y6DsG66LRxDhuH8XwsHZSv
         u5E462/5bE/CQ9evoUxaMrLZ9K5hCv9WRGwnbqK4/d6/bRT9zGiiwpFJTUvlEzH00HuY
         b8fGUVl37gftDO5FlKsv2SHq/ZTNKcHC/md7rQkXk6O/8FlGUKNq5RtP8aHk641ymllu
         0qYjEU5dSMA1xBei7tOHn4FLEdxMK8TdZ0a/tW/xZK3WxIQVdeNwY+YFk4hWt5QSMg61
         kpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760533891; x=1761138691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSEXKmipGPjNX9UpQ1OcPNXCLJIBowGxqHQC/E69W1E=;
        b=nsQd6QFvdLtPdFLVqzNRM9tv9PqP6nj2CwT82G19iCnuR+vg+XP/WNxRJxxjG2rDaj
         a0R42lGFcqIHLljBpSgl53uKtWYolsK1JPdLz3Ck9eRYGKhwtVVFaIdDu9wQvaiKG5k8
         UFR0ZH4aGhXGoRCYSp1ZrSUplYxj7fHfwnkYr10YQGhpVijPRPEh9OXPRM3eJlB/MBuB
         WZi/HB2nx5+VRa7lrkPeebvxggR0VO38JgNYN86bs+yiGJyQrMBtt0/XWktmckyDl37b
         jph8Hi2e/75ms+TsMePq15JhIHwNLpactDnAcYFgLD5LluQGmpulFlWOUsdamPD9kYaN
         HIHw==
X-Forwarded-Encrypted: i=1; AJvYcCUOB+F4V3X2c8ZwvsJEpcKNQG/VGX1zGyfy6fb0M/C1/3n2UG2FDgNvRRUAmRmSOSY1D/112K6/zAH9uSb/WFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCHt2AF8WH5cl5mKs4SfuMxqiAm3MxPIWKW4vXoDVHG7iSPNK
	SADjKfscVTNTIKLW9YQMaT8dWdR8vOlPJR+bdXQsZzHW7RCrpY+uHRINS+MXHevUXSw=
X-Gm-Gg: ASbGncvRyN95FCJ6+NKLLP/PJ8L8p0xC6vpN7g/i5s118R7Y8fvQAHXtDmVKL76eBGi
	6XiSOzjp3pjgqPP3QzauLrKQ96qVqeBFVy2Z2b2WdM4wYjrF65CDjBQZwK//jsbDQsHfGllTVjM
	T7iBoE7Ua+bj4Rgt2jsyVO5r/7yYD2rxJNwI/E3RDQo1oI1OtC9W9jLuAHadPHhllQTXJVUK07Y
	mdVC10owhhrERjz+ynfngHiuaJ5Ai+wcCJz25uyi66zereTxKC0YvcLmjNZntFjpzgTAunBCmlZ
	D8B4+WD8kuLWL76G6yiuPNPbGLoVXXFq0EXlpoJUuAQCPaKtqKB0zwXZIIRfuVcHIhqmplbJDME
	80xZVzUbwijOhIIdjqPRMC1IlPp8TUQUX6n4tHjte8dTqsM8XO0LCwik=
X-Google-Smtp-Source: AGHT+IHb7yqFd13CCRX2ZsPulLnmXAv3Os19z37S0V2UZLXAtIujA1Vyw8h33iB673wyOzI9vd+ODQ==
X-Received: by 2002:a05:600c:a309:b0:46f:b42e:e39e with SMTP id 5b1f17b1804b1-46fb42ee4femr110401385e9.39.1760533890656;
        Wed, 15 Oct 2025 06:11:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm294145175e9.4.2025.10.15.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:11:30 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:11:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: use canonical ftrace path
Message-ID: <aO-dgBgwnkplkZtL@pathway.suse.cz>
References: <20251010120727.20631-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010120727.20631-1-wangfushuai@baidu.com>

On Fri 2025-10-10 20:07:27, Fushuai Wang wrote:
> Since v4.1 kernel, a new interface for ftrace called "tracefs" was
> introduced, which is usually mounted in /sys/kernel/tracing. Therefore,
> tracing files can now be accessed via either the legacy path
> /sys/kernel/debug/tracing or the newer path /sys/kernel/tracing.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

JFYI, the patch has been comitted into livepatching.git,
branch for-6.19/trivial.

Best Regards,
Petr

