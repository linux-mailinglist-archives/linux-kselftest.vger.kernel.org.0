Return-Path: <linux-kselftest+bounces-2275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2269C81A615
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 18:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F6EB20DBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C2047790;
	Wed, 20 Dec 2023 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poN48gjs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097594776B
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Dec 2023 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso8236373e87.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Dec 2023 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703092377; x=1703697177; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB9ev+uMncqth39tI1tRydoRsIX73JNNXrX2aWeDi9A=;
        b=poN48gjswwuk8mYxNPgd8V3OSvQvaRT03L8QIyN+lh95Wegm7sBtUk+tn5ZGrfPjC0
         6fCoPoc52+9y6+caYIVRrwHjel+4K3YRBTN2O0hmNkmjvRUr45TwGovJzKobM81Jl+RN
         6PvTHWOlX0maV1WWxyHMOLcW0+YIhVD4VEMDcUnlZsW4tv7UpYU/F3QCQ+Rq2KcBzB9F
         l9NEjfi72+ihYZJXyJQdYfPvtdoY+EjUc6DPsLEYRS2mQj7ArndIpS60WDlckNSXEVhp
         FhZwcsHDu5Onukw0U9WXTG2YFwpgvy09y1/Kk6JKMGn8p2BMjXNiW55cM9envXJu4TM6
         ybtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092377; x=1703697177;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB9ev+uMncqth39tI1tRydoRsIX73JNNXrX2aWeDi9A=;
        b=Tor/+ke4yiIkg9DX5oWgqmwYi3D9KQx/+nk44yP/YPMf91rBM8R45LigcZ7JHs74PR
         RZIZhgN1WgacJC1AtbEqfubbBJfTjgwO6Nf8+iFwB0AfQMBpYEhU2ii6CLbp3FPpQrYo
         NevMYgKQjZ0At/q/9WICzh1MLBU+iXAQWpJORQ0/2jYP1W+7j/UjJvtJh+p6V1xgNcnS
         oNq9A7dy1H9vGXOjn7nDNovPJZh0lWPb3uHaivmJYEvZmtfR4YLD95tcLELDCMnaU2hQ
         dKh2DwaN6ylrc1fMbdBGWciLJM+YUZeyoz1RecCXX8zkWcen0yLDcKavlHWWdO2i5aQR
         CScg==
X-Gm-Message-State: AOJu0YwnMfw8BtNL3f4XjSGUPYBfIHikuhSLKNU9CXo92WIjxv6hrFXs
	1w8GQL/ObDt8RaASUVxAkhGtqw==
X-Google-Smtp-Source: AGHT+IFNb/zRS/yfTqowxh8HH2imsPZuzJjNgYk9xNKk34o9tgTlDX+1Uvy0Ra9NlXWnkdN4WRTWyw==
X-Received: by 2002:a05:6512:3c9b:b0:50e:50ee:f378 with SMTP id h27-20020a0565123c9b00b0050e50eef378mr1005745lfv.65.1703092377027;
        Wed, 20 Dec 2023 09:12:57 -0800 (PST)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id l15-20020ac24a8f000000b0050e23d8af76sm14916lfp.137.2023.12.20.09.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:12:56 -0800 (PST)
Date: Wed, 20 Dec 2023 18:12:54 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest/seccomp: Convert to KTAP output
Message-ID: <20231220171254.GA1278954@mutt>
References: <20231219-b4-kselftest-seccomp-benchmark-ktap-v1-0-f99e228631b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219-b4-kselftest-seccomp-benchmark-ktap-v1-0-f99e228631b0@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On 2023-12-19 21:21, Mark Brown wrote:
> Currently the seccomp benchmark selftest produces non-standard output,
> meaning that while it makes a number of checks of the performance it
> observes this has to be parsed by humans.  This means that automated
> systems running this suite of tests are almost certainly ignoring the
> results which isn't ideal for spotting problems.  Let's rework things so
> that each check that the program does is reported as a test result to
> the framework.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Tested these patches on today tag and it works as expected.

seccomp_seccomp_benchmark_native_1_bitmap pass
seccomp_seccomp_benchmark_native_1_filter pass
seccomp_seccomp_benchmark_per-filter_last_2_diff_per-filter_filters_4 fail
seccomp_seccomp_benchmark_1_bitmapped_2_bitmapped pass
seccomp_seccomp_benchmark_entry_1_bitmapped pass
seccomp_seccomp_benchmark_entry_2_bitmapped fail
seccomp_seccomp_benchmark_native_entry_per_filter_4_4_filters_total fail

Now with this change it shows up in the results.

Cheers,
Anders

