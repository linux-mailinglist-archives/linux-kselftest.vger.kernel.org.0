Return-Path: <linux-kselftest+bounces-7045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789EB8962C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 05:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B63C1C22A38
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 03:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCA1DFF5;
	Wed,  3 Apr 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eKfosnEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB01BF2F
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113775; cv=none; b=PHuuqputQzXDPuQZ2ELt+HfIv4ovJTQPkFBM6/yWL9MLtA/WP2Lvd4lmt2COYlnmVwY1/NkaRQnsjqA1y8uMAfK4kjwl/YD1RLG3trm4RNK0/wFKWInSxzqSNMpqK2827xCtGyD0BKJIEtGRKCmgooanFgS0z4p2QjotuU/4Ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113775; c=relaxed/simple;
	bh=mqZmH8sgDOreJ45kHkb/4Z3hhf3yHMoDP0ZJPVs1o0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfWqdH4CuzQvLmWyeoDF/E1EMZAnw4TAlBEki35TkB0bpwhXK4Vfkw1gTUJwgu5HEwne3bfko4Ci5hWlmstvVy/RrJnhFKXuDnMW1YJ6up8qUopBykelybRlhUJbY3tvenU7BgLAkWLAFJrzaG/3IKlAucT6W1opkUaAmKkCfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eKfosnEo; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a467dae51dso2325782eaf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 20:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712113773; x=1712718573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKzS4KBDMiq6LSGZLwcPvfHlw5lOtQQSAMAnuCzAzQM=;
        b=eKfosnEoFdWb4N5a5vWAP9HyVYjodrB+QKpxLDgs6RRjv2uLuiFipaV7SWMGkFmRmt
         Z1IefZ46HWGFddN7MJvxdLWQab705wIg6cLoy+L/NQecVboc3xILh4i0t0F0XbVHvt4V
         MlnGWaRG/Rx4xGDNdl1t1tRsHZiNDyQXLgSHh+ywIAdT4DUwdPwnvcVAdEl1xKvYf7XN
         xiT5MKWo5bEAhQ1ekJ/K9N8dqXsDm5lKcpx1KLdck2xba7SErtr7fWQkytFfqYls3yP4
         yV9RSvxNqLJh4Sm8fQUx1aAcZtHLefZ577Y3rxyGCnc0O/cw+WweYglvH5a2uN65KeZG
         yryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712113773; x=1712718573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKzS4KBDMiq6LSGZLwcPvfHlw5lOtQQSAMAnuCzAzQM=;
        b=dAm/JbrRUozJAqnytDBQzjRlJ7KBoiFsqqnQqvlBJx0g3/+Hz9OtUPRiTzbhVT42ss
         NmzPjZdWMtzMoXjZmM1sLW+nO6o79EgvRd72p8YTsMk5YLJhT3rsLsxB1SuLAs2vhoFA
         G9heXmYHmK56RwyBLFa4S8IDKcvbTQVsFUza3OCFpa6sWVeRozhgQ0UA746TjnL9JAyF
         /yraVLNDTLXWrrhewF7Eo+id0uvVTxVGL8CnOAfEhoyO2jz70hM8HOEkL+uERgq98udD
         C/kupt8XqYK2XI3H1smaMPnr2MHd8ctjUQgubIh+VpaPHJGInylDtSY2SE6+VoJz+DeP
         2TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVzYnGSpiChhC87aYGwSpRsFNN+CEOtK7c5c67H5255McdUPqLFLCLAmsV2VfMISRZI0sUM8N9aI62Uf4wpkfgaJ6CfIACWutf4dvJhYc
X-Gm-Message-State: AOJu0Yxg0NbsLVUYqnGRZLW/OZ72gSXtBTx8E5G+HdjMoHsCwxMkdDcs
	X1XdSRp6cqCv623n2owniJU7mpvCPESSvKVADEAorSMo4Vno38DOVP3HqbZxzSg=
X-Google-Smtp-Source: AGHT+IG1u3SPera+hr6f9GHe/5ksK2AL19+a+ZEVlxwOS5MKedLjRIKmi/pNSJH/zevQ+BogGDPo4Q==
X-Received: by 2002:a05:6358:3a0e:b0:183:612d:4499 with SMTP id g14-20020a0563583a0e00b00183612d4499mr16713612rwe.31.1712113773063;
        Tue, 02 Apr 2024 20:09:33 -0700 (PDT)
Received: from [192.168.1.26] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id 13-20020a630b0d000000b005e840ad9aaesm10547497pgl.30.2024.04.02.20.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 20:09:32 -0700 (PDT)
Message-ID: <fa06578f-9b08-4c44-9bc6-12fc11bb3273@davidwei.uk>
Date: Tue, 2 Apr 2024 20:09:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-8-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240402010520.1209517-8-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-01 18:05, Jakub Kicinski wrote:
> Add a very simple test to make sure drivers report expected
> stats. Drivers which implement FEC or pause configuration
> should report relevant stats. Qstats must be reported,
> at least packet and byte counts, and they must match
> total device stats.
> 
> Tested with netdevsim, bnxt, in-tree and installed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/stats.py | 85 ++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/stats.py
> 
> diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
> new file mode 100755
> index 000000000000..751cca2869b8
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/stats.py
> @@ -0,0 +1,85 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_in, ksft_true, KsftSkipEx, KsftXfailEx
> +from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
> +from lib.py import NetDrvEnv
> +
> +cfg = None
> +ethnl = EthtoolFamily()
> +netfam = NetdevFamily()
> +rtnl = RtnlFamily()
> +
> +
> +def check_pause() -> None:
> +    global cfg, ethnl
> +
> +    try:
> +        ethnl.pause_get({"header": {"dev-index": cfg.ifindex}})
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftXfailEx("pause not supported by the device")
> +        raise
> +
> +    data = ethnl.pause_get({"header": {"dev-index": cfg.ifindex,
> +                                       "flags": {'stats'}}})
> +    ksft_true(data['stats'], "driver does not report stats")
> +
> +
> +def check_fec() -> None:
> +    global ethnl
> +
> +    try:
> +        ethnl.fec_get({"header": {"dev-index": cfg.ifindex}})
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftXfailEx("FEC not supported by the device")
> +        raise
> +
> +    data = ethnl.fec_get({"header": {"dev-index": cfg.ifindex,
> +                                     "flags": {'stats'}}})
> +    ksft_true(data['stats'], "driver does not report stats")
> +
> +
> +def pkt_byte_sum() -> None:
> +    global cfg, netfam, rtnl
> +
> +    def get_qstat(test):
> +        global netfam
> +        stats = netfam.qstats_get({}, dump=True)
> +        if stats:
> +            for qs in stats:
> +                if qs["ifindex"]== test.ifindex:
> +                    return qs
> +
> +    qstat = get_qstat(cfg)
> +    if qstat is None:
> +        raise KsftSkipEx("qstats not supported by the device")
> +
> +    for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
> +        ksft_in(key, qstat, "Drivers should always report basic keys")
> +
> +    # Compare stats, rtnl stats and qstats must match,
> +    # but the interface may be up, so do a series of dumps
> +    # each time the more "recent" stats must be higher or same.
> +    def stat_cmp(rstat, qstat):
> +        for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
> +            if rstat[key] != qstat[key]:
> +                return rstat[key] - qstat[key]
> +        return 0
> +
> +    for _ in range(10):
> +        rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats']
> +        if stat_cmp(rtstat, qstat) < 0:
> +            raise Exception("RTNL stats are lower, fetched later")
> +        qstat = get_qstat(cfg)
> +        if stat_cmp(rtstat, qstat) > 0:
> +            raise Exception("Qstats are lower, fetched later")
> +
> +
> +if __name__ == "__main__":
> +    cfg = NetDrvEnv(__file__)
> +    try:
> +        ksft_run([check_pause, check_fec, pkt_byte_sum])

Would there ever be a case where you don't want to run every test case
in a suite?

> +    finally:
> +        del cfg

