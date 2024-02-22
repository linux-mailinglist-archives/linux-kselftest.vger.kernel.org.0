Return-Path: <linux-kselftest+bounces-5295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFE85FD21
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 16:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5291F22906
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4414F9FE;
	Thu, 22 Feb 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="ZutQ0VjE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E314E2E8;
	Thu, 22 Feb 2024 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617264; cv=none; b=fWOa5lbiIwe1WlkPK20PdcKum/JqJAhy6JEWWIjLMlgVd9DE3UMFcRS4QdILFlcfTeGzGOVoN/o8zV3/2uxPG6EMf/BaYmW4ofDD8OX/DoCciyhK/Quq8M44SH+6RJ5wUcrXc+/EdiY7uzEozTjtxzDyQ6RTty8Iy4T4ycvqzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617264; c=relaxed/simple;
	bh=7QeTSQb/9tcAKQ4h97LCyJHM0kVqV+IqwGX4UOeNj/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLEG8plK7mATVGWXtJlmyq8wJ60NtHE208b1f6C69KmuSLyu/lQgPDaR7C9hJCuCCnL4Q8ZJYKDiuiWDN/k2Aeuso88mNEnp+lNUMEx2tup/e6yqopqL0kaM1zl5F3V7W5mN2vu99i0RuXEDYc8vraon4cKKIPwi3gR9oMMsZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=ZutQ0VjE; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1708617237; x=1709222037; i=kernel@valentinobst.de;
	bh=7QeTSQb/9tcAKQ4h97LCyJHM0kVqV+IqwGX4UOeNj/w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=ZutQ0VjE5tQotyW+XHFlbEPqulDcwN9zME0rJyO7HRMzQJjKQ27aDRKUcCKt8Xgf
	 Dn0vOcYh45UKzqbJ/IdTsOru+xRr+bwtHS3emSwaOxTxHYeNy1/MV+7QgVL7ybt0x
	 9QTHe+ICsbg3SZKlPZ2buO1W50eIq/0buMdJnbu3fHuvzCDx8giHZHVe6jFxjaEWc
	 9pa7w5ZMuEhd7eoTjSWMbjg6Pgx+0KFBGPtgJoZshgh4CfpwRipvYr7X4bOR0PCmh
	 I1XUNJe32yZWliE5uANSeLUNTzmMtg5FjCQsI/Gd+uVdJDwcLLK9rkZpUB2TWS1n6
	 3Ak1LRWqOVytP0uzZg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhWx1-1qyul53K9j-00eakj; Thu, 22 Feb 2024 16:53:56 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: laura.nao@collabora.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	sergio.collado@gmail.com,
	shuah@kernel.org,
	usama.anjum@collabora.com,
	wedsonaf@gmail.com,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v2] kselftest: Add basic test for probing the rust sample modules
Date: Thu, 22 Feb 2024 16:53:38 +0100
Message-ID: <20240222155338.26836-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222151009.461264-1-laura.nao@collabora.com>
References: <20240222151009.461264-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:UzBpTg1mY+EZdjgUCI/z3dtqZmx+AkuLKocPOsQ17saRdDlkNLg
 LDs6ESpF9jsP1w8DSqP96zEBT51JtlkhFmMczvMN3dtlvWrobuvkOkFEQz9InzjXqCvW47W
 eUG8ZqzrhlpvjaeqdRLJg54v6taJuD0cIFWBSaFLwaLMw8PF7vWFWAUUQqKxIkUICc3AEWe
 r25NBtGKt+Qsdl4KIkWVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JtIm3exvgr0=;ee67eIFxmwa1VbCY08m7Bz0MlmD
 TqUTm9+L1rnBDCYsbkRYOQ0f+qm+qap0pvbNgChMo8Wa3oqTt1o0a24VIZgx9GIeIsVb8AM0C
 RsqWPhMWRvsUBBdjxphxTGtoOPSg+hcLaKvct0+3RZuV71ddvZ2KF77tVXKaWJnqi7ovPmLRO
 iWV/jfu+gw07pUgjP+jxH2Uid7woetKvspfCYKFPzKD5gja1uwDP74IimJ+uCPkbcGUcwNXvT
 FXEjK0KsL76NkXxQk5smXoK/vvO7ge6NPKNMOUdOL4mGwEaxpSMfwJg+wuQ/TXR7AXRK4XMjn
 fPxq6cfXZGxzm+1P6CIZ57ZWFY8nmsaAWF1lEh/fN6d5AJiRGMjSzqptDOldn41nXdWN3Agor
 yGo4fS8KtW38Axpqcfmf/7XxGqCixp3glbr7TDDS91HZ8UzHTC6Lb/3EEJwzRPoZqcfM/HvGU
 8Pa3eQZTH6xyMqJvjA7J/hkqSOfT2uKnZzBeGld9SCCi2JCgaj47IsXyctJfUEZxWuQmV1/DD
 r4fT9dgcC8IiB7a2SECcqaLaQK5dVvlFHeHiGI+TK0DadZT3+v0pU6Ig9CySgm8KajPwHT7Zj
 HFWy+Fc5T1Kzs/kIknczgq2q+B+m/RGQT0eNIFC36yZ/o/Qp382HvCddvwLuXFUbDd9u82fiI
 AJAY8+Nx3NkPbMxQUXZWpZR6FzBqcqXyZFz6Ga/lAdCpaC/E72SfgOWIeAw2g3zg0QXEMRDKY
 hon87jXTTYARdBJ0SduqRoQQ66dNSrC/nF1McPJe3fCMz9b/8zOF9c=

> diff --git a/tools/testing/selftests/rust/test_probe_samples.sh b/tools/testing/selftests/rust/test_probe_samples.sh
> new file mode 100755
> index 000000000000..6fcc2cd83d89
> --- /dev/null
> +++ b/tools/testing/selftests/rust/test_probe_samples.sh
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2023 Collabora Ltd
> +#
> +# This script tests whether the rust sample modules can
> +# be added and removed correctly.
> +#
> +
> +DIR="$(dirname "$(readlink -f "$0")")"
> +
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +rust_sample_modules=("rust_minimal" "rust_print")
> +
> +KSFT_PASS=0
> +KSFT_FAIL=1
> +KSFT_SKIP=4

Aren't those constants now defined in `ktap_helpers.sh` as well, i.e.,
could those be removed here?

    - Best Valentin

> +
> +ret="${KSFT_PASS}"
> +
> +ktap_print_header
> +
> +ktap_set_plan "${#rust_sample_modules[@]}"
> +
> +for sample in "${rust_sample_modules[@]}"; do
> +    if ! /sbin/modprobe -n -q "$sample"; then
> +        ktap_test_skip "module $sample is not found in /lib/modules/$(uname -r)"
> +        continue
> +    fi
> +
> +    if /sbin/modprobe -q "$sample"; then
> +        /sbin/modprobe -q -r "$sample"
> +        ktap_test_pass "$sample"
> +    else
> +        ret="${KSFT_FAIL}"
> +        ktap_test_fail "$sample"
> +    fi
> +done
> +
> +ktap_print_totals
> +exit "${ret}"

