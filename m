Return-Path: <linux-kselftest+bounces-10991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8767C8D5CFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 10:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86B51C23DDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0A153BE4;
	Fri, 31 May 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UfYrAAWd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13868153BDB
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144933; cv=none; b=XGI/Nh6qMeswLCDO5Ii9aa5Wdsgl2aA90xS2MmlT/EOvcm6JPXy3h66mDbG/KSg715ON6k+iN40ubexdQUF0S8EAGoQp1GG5VegGY9L7kjQVNMH39y9AlR2gDdUTJuHNO8JfLA8fXcdEcEktXWE/fO3cB0mMJSK4aOc9RcRvOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144933; c=relaxed/simple;
	bh=4yK9SyBdW0zgwmNl9s3wi8n2UWcuNwjF8EG8EoaUDU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW2e+InLyERrK8CvJNnFNpS5wm+hQ/E5x9J6idrYlftKBJNpuJGm6DdpvvXjtMUdhEvFSeGP4k0moESWKslxl1KXaIkhFliZM90m2kjps5gCQl98xj1FKnD8FvcDMbjaeX7dKfE7Lr0K8GGAxu+YZIekZcEh52JYFy+QVxiPHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UfYrAAWd; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so1594100a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717144929; x=1717749729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEJF5YFjXx3H2Urn60X/VuHjAoAlnqwvGpoDCqgBZM=;
        b=UfYrAAWdHylShCEbxzOoeOw0Y8FuzftgA7pjjJVrdlGGvFxn9WYr3PQfb0URxtY+Zv
         c54xnW/qxO+Cd9eaBn95RZb4oQe0P/tEznbVq9qRwYtEO5oktDtr4zEr50SeQP05PUTK
         2bPkqA36Ip+O4cFSsDliBm3Va39q9pxcb15pDvGRXNdJWsBMRCZ8wn7BycR7x7FHa2YX
         Wjs2vLsrqQMTQjLbu/MSRKqBCQZ15TNVYiY3KNd422BTzPjPsuu4BNyFgA+8jAcjTRuG
         BTaAi7F9lBZn6EM7YdY7ozLgm6dfIXOWwINt1AVOLTsGXFn7qssTjEQfU0jKFvXGY4Vv
         9cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144929; x=1717749729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnEJF5YFjXx3H2Urn60X/VuHjAoAlnqwvGpoDCqgBZM=;
        b=O6AhiiqAqqn/J8bsDs+gAVmGPl8KhPb/rIHEgWIxWEh3yDQQxVvJYkubq/shTdRDUF
         2J8pe8m2NdczqQoGC/CbSPKShXGjB4UsYLFWgXbVIND5w4WtipMxIdtE9SpN95MNXNff
         bskmQPulBArZdf5CDmkHk/QPN6CnfO+qwHHlyHFwwmqgoPSRKKsimEvaRQ1UCmqZSYs8
         QU4HLpz1BJA3qVIqxwAGP+19zIYxqFhIlb2InjknOKo0GKaQpAcn5iOXCzafLMpPvmNb
         MJHWcMt2AfJ7zQjkWJWIs5OamKr/WqqRWyHozRQU0V2fvInxq9GUZYntqtgWMbHX+XUz
         yAyA==
X-Forwarded-Encrypted: i=1; AJvYcCXJbXjjeHUbNH2p3LBcZqZ40yl+nPKP9kIMgS8CGmUMC2Ln6meLVSrIxb+hnVESvT4CrgjJGcZnfPUQxAsrdafLZLwDzmjsEemnk//GNM/Z
X-Gm-Message-State: AOJu0YziYB8FAdOdbCEPWfkIo0bbXe5Ka0wcCh7jhBY2nsIHcr3hpWud
	SPAsSAJ/UXJz4ldgyFBHI8DDCnQC5kPTUdgcM8mc82UbOrualyrX8mwmMNkSoqQ=
X-Google-Smtp-Source: AGHT+IFaI4U2rH2Rd9l/+r9yzVCwe48OPbQ3/TkHlZBslQk9PqBEy0Gw2qtSg9KR6sBLoLVxmyYr1A==
X-Received: by 2002:a50:d4d9:0:b0:573:5c18:c2d5 with SMTP id 4fb4d7f45d1cf-57a36382781mr872799a12.3.1717144929374;
        Fri, 31 May 2024 01:42:09 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb8282sm734725a12.25.2024.05.31.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:42:09 -0700 (PDT)
Date: Fri, 31 May 2024 10:42:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryan Sullivan <rysulliv@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, mpdesouza@suse.com,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] tools/testing/selftests/livepatch: define max
 test-syscall processes
Message-ID: <ZlmNX78SCFX2Kj3O@pathway.suse.cz>
References: <20240529201941.13968-1-rysulliv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529201941.13968-1-rysulliv@redhat.com>

On Wed 2024-05-29 16:19:41, Ryan Sullivan wrote:
> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.
> 
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>

Looks reasonable.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to queue it for 6.11. I will add it into
    a pull request for 6.10-rcX if there will be another more
    critical fix which would need such a pull request.

