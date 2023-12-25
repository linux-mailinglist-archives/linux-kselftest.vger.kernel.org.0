Return-Path: <linux-kselftest+bounces-2418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36D81E077
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BEB2057F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Dec 2023 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382235887;
	Mon, 25 Dec 2023 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIL/6fzZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D072574B;
	Mon, 25 Dec 2023 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3e6c86868so29866815ad.1;
        Mon, 25 Dec 2023 04:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703507955; x=1704112755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lt7y85wdBzW7T0fKOcTK5uAk2Vc6N/J05wAxgQgPaB8=;
        b=BIL/6fzZcQPRY5VbtzQeHUKeyFBNz4ggikrbchwA8DYYaC+laENLsYJqIiP5DXQsyn
         GMa8cLNJq1Aiq3Sz8LFUVLxuN5GymeICGI+X7guuNehaivfwpH2R35tQ41FrHx6zHre+
         0w3UaxqYm3IJjP2QNzgNsZLwqfTJYalPmNOpN/TnBUjSBYzI8E525aNc14N+ZNxHPlbL
         zXFdlmVeukXd40JFOZk7Ow9rqnqqoeRIn6oFLXBWvasbMjX75Mkw4ydKbJmyisqQIZdx
         8Rp7D8iAD4zO2fKyu8CP3XL7QoKE4Hkq9IdzV6SUCwHyb4oOBML/6gRNeYWTrDdJvVAK
         5Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703507955; x=1704112755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt7y85wdBzW7T0fKOcTK5uAk2Vc6N/J05wAxgQgPaB8=;
        b=iPAp9I669pW9c7yPHnvAUB2H2StEO9g0XfCltV9xUrPikoTKIjwiF468M9TOUYu1d+
         Zd1hCdHOFuLEGlNmrwL6OqGOHXG1xkkQcdsOs09Olyzmmto3QPYvztSjwpia5YT+aYVI
         XoFB9xgtCPxEnM/gfnLt3nj9AJXIg66mMshH/gX/1+DAt6ct9ISsJQ5FmLW6v/ksYvi1
         QGEru2qDBtKgglMPyicPpIEHZjs0VpVd2IHFIbq4CAvIliQkHYOoNXQL3kO2V0e0i+hI
         Ugr54qQTJfZuzDqR1KKUrQqWXykcVYSyIzXd/yfUUoOSdTzcbTR6REXlrBP+eN+syAvt
         97Wg==
X-Gm-Message-State: AOJu0YyRMsp0ZTH8yXroGLJCY1YMgHULrNmYcyuJF7eByxTIJjkrKjIU
	9bsqjfz0RkMN6jZjm527LUM=
X-Google-Smtp-Source: AGHT+IGgcUupcgnEjwe5cz+o7NA3nD2BSC5KshmWoyOnv/mTiHcnok1KfGIqVTNaAwtMz0IcUCKSog==
X-Received: by 2002:a17:903:603:b0:1d3:c21b:db5a with SMTP id kg3-20020a170903060300b001d3c21bdb5amr5488895plb.34.1703507955502;
        Mon, 25 Dec 2023 04:39:15 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001d09c5424d4sm8059719plx.297.2023.12.25.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:39:14 -0800 (PST)
Date: Mon, 25 Dec 2023 20:39:09 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, lkp@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH net-next] selftests/net: change the shebang of
 unicast_extensions.sh to bash
Message-ID: <ZYl37fnxGGop7VCs@Laptop-X1>
References: <20231225072109.3835503-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225072109.3835503-1-yujie.liu@intel.com>

On Mon, Dec 25, 2023 at 03:21:09PM +0800, Yujie Liu wrote:
> The patch set [1] added a general lib.sh in net selftests, and converted
> several test scripts to source the lib.sh.

Oh, I didn't know dash doesn't support "source". Thanks for the fix.
Would you please also help fix the pmtu.sh, which has the same issue?

BTW, you can change the "source ./lib.sh" to "source lib.sh" to consistent
with other tests.

Thanks
Hangbin

