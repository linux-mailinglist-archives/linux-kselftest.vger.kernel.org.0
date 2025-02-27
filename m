Return-Path: <linux-kselftest+bounces-27805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE094A48B23
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17F17A5D58
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0247271821;
	Thu, 27 Feb 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjyrvD2S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63899225775;
	Thu, 27 Feb 2025 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694255; cv=none; b=CDBv/QW2ywVOfQwz495I6C85jsCNjC/MEaQ2LN+9RkoFYH20Z2RJpkRjHyNIeE2a/QW1z1WZPZK89JO0LnjAQqFHkPkXYk8UoltIA+ufRy9MexusXOyPYViCAB1E6djEK4d5OW7GaLUFp6lazAYSmL98zUuzID9psfm/t2RsZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694255; c=relaxed/simple;
	bh=b2DbF3ltZd0nN7es/iT+JtNHxJ9qBCXLl9BbNr5+jPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYFaQ6Eu1Igb5snahrx+F/M9TFiLrvP7P5dXrposzxrhahAhsjJUaNJDbDq0BgbUs4s0tXdMQTJvH20Gs2ikdW2awxMR7hn3L6vechfJZNbn2sajUaF08s0sXuFcyEPHImkTxrMZ9d47KfIbc/lN04kcfTG/FgA+B+BHmkGMHHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjyrvD2S; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2212a930001so37930015ad.0;
        Thu, 27 Feb 2025 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694253; x=1741299053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rn75LKwtmaH31i7iljvrf4k1hEdFxHBp+jzGhRWzFcQ=;
        b=XjyrvD2SugZCRFhvBmvGJAWvv7KjNK/qacuCeZlIzprVmoBemCs7qLkN+hR5usMBG6
         uHhDCfYYpaATCvObASYCCXTW47xrZ9n5xREx7HipsfmgQ9g+hZp8i4cFeYsm2R+6SPmh
         7zOnz/GqQ+k9oea1C79sQKDO36pih0zUuvKs3C9tUFSuk6t2MOoPNULHenaYO/wFfAu8
         9HDBLnU15a7/d334jBEG6VlFE+OhMVv9qBT90XQUblT7hAECDBoW+TnnWE6OcFKz1zEb
         CJb3aDZ3nr0TbOTfDr5fF9FzpRpX1EnAd/K8JotHIpxVTSHvo0OvXuMnUo4PAPz1kNhO
         atWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694253; x=1741299053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn75LKwtmaH31i7iljvrf4k1hEdFxHBp+jzGhRWzFcQ=;
        b=PnULdmPVhgrpDfOSceKot3YPufxYEh6nVARlVX7BGa6PKLMBItnahIV+8fLVn1fPt8
         NFlNWp7O0SmCNW2cQdcZskoUVEq253fEmpRrg62SsPYh7cgbHna6U4mShJgWeWzVXWsl
         XxW2nIL8Pdn9/8C+TJUfM5npxM0C/o7LDZUChbUqij4Jtts5n4zDFyHKloL5/EFFI7cZ
         0ld0jQfVSRfeFYkL6bj1NvJZ0FVL6j0pc/6z99cburB6c1o8oT3SofGkelcE4yHO1tlw
         yKRNOhBwlxwWXvKsnrqhBAHQK7IqjvE5VF9O8jQdqBSwBx6ANID3tL7Nedwd3s1W4TAo
         hGIw==
X-Forwarded-Encrypted: i=1; AJvYcCUzhOHZPH8IyLTWQdGMcVT1w4iKxs9elcePSgniQ5NMCiYVgMHt/Sa8zkVltxaiQaRysSGb+V5qBYULtrcK@vger.kernel.org, AJvYcCVUTS4NvyLcvYvXxTDE4LQ02Sp6XRvnYeXM291W9tg7RPF/ehhrA8eLf/eAMlAdidWN/Xr+ubDrE3eR6w56VOaC@vger.kernel.org, AJvYcCVXcqP1L7oXiqqN21bz6w/Y+V8knitotQnzEeN70bxrHgs5XAu05KbZRMDJ0Lo//iJ0Soc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6gGmwq2TDOYkZK2HYDt0JjNZ82CM++cYw0eiVEsDIaUCh+Pr
	z5JIfejUvM3EysYFJyi2ZYNMD9E0BLuznkI1SR1pb+zS4/SruDg=
X-Gm-Gg: ASbGncsdTQLVt60GphGAkASMQkM8LHM1rqrrb8I/NGP4SNdHViRTbg6rjTMtZJvgcE2
	j9YJBgHGM8shB+cJln8K9wq9uRH7R/5gNu+oqcH5R2DIP+XUhefC5KVxTMUauQDjNyDHjlGfEvE
	YQ58ju3Mh1m9dZuUjWMdGFAxqdV4WlC2SwTx6liVqv4u/ncCNdVY3uDMEhqpQlXAwhP/FqCPGuX
	PC/dRECFDeT6A2n07RGSJ9bZ5eZoWegL8pB6RfmV5jB77uuD8ojRXz4SIlZJQiKkKPbB6MrEVX7
	lI9bmCzleMHLocDPq7lJNOlyXw==
X-Google-Smtp-Source: AGHT+IFOdJt9fg/q+E9anyq2+KmyHCqG18NxNGhDQrrrbDAjF50JPW9jOcWFireSwb3MB344jcTswA==
X-Received: by 2002:a05:6a00:228d:b0:72d:9b11:1ebb with SMTP id d2e1a72fcca58-734ac34ca79mr1999976b3a.8.1740694253567;
        Thu, 27 Feb 2025 14:10:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe6f066sm2233065b3a.83.2025.02.27.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:10:52 -0800 (PST)
Date: Thu, 27 Feb 2025 14:10:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 02/10] selftests/bpf: test_tunnel: Add ping
 helpers
Message-ID: <Z8Di7CSo-KH1Gt0x@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-2-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-2-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> All tests use more or less the same ping commands as final validation.
> Also test_ping()'s return value is checked with ASSERT_OK() while this
> check is already done by the SYS() macro inside test_ping().
> 
> Create helpers around test_ping() and use them in the tests to avoid code
> duplication.
> Remove the unnecessary ASSERT_OK() from the tests.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

