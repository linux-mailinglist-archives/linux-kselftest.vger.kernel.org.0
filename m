Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9C7DD78F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 22:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbjJaVMK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbjJaVMI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 17:12:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D1121;
        Tue, 31 Oct 2023 14:12:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77891f362cfso21598285a.1;
        Tue, 31 Oct 2023 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698786720; x=1699391520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFxxgZ+Fgjn1lcoQo+YsIsOs/37eq18CPfT4n4AOfJI=;
        b=dfgyQh2i2kOd4GMBeaReEVkOUCId9F8UfHVAo/0oYNTZKDMAxj8DOHgYYJkVAPwjLx
         D6/r/JS0GDg9xL82eBq08H2m37/Kp6m3aMvXcqHfQYNhJ61OgtqMJeXDqPEOwjekeOyk
         YNIQIRkVI1z/ImYlV4jgntWsFPx1iXI8/ES6oS58erjn1IU8ZVmRJZ044UVfJhOwfMJ9
         KkJrcoOzL0YYEo2gREcH983UKv4V/wMPgCAehdvhw+QYQ/UrzOS88vf8nKJnfhs5yTFL
         EQlI2rNbX6pZtZ7f9+RZfXy1MshrSHZsEHcIILj8h+0iIeoUzLAqdoV1S79gghdtIOmH
         ZlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698786720; x=1699391520;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kFxxgZ+Fgjn1lcoQo+YsIsOs/37eq18CPfT4n4AOfJI=;
        b=Mi3ulmUYxwJgGFOPkxEuvulII83LzjaANCgstYfw18OS3E/bph3yj4fi1zFJJm0z8/
         +CoYAOOD8yXk3zJ0dlsCdjDWc6sT/tS9vZZDdyO0cUfGORz0IdN5R9Nd0gmeXNASfN9I
         xSV+ntbmYX7QXn0LbNy5xJKc3cfbG/MIBSxKbHfol50Mfgyst5M6Glp+ErzqcJGTuHWI
         +RtsrIO97wEa9k7zM8912b0SAmzKaLALGfUTxdKobDm0wB6cuIZEsvZQHQQiyhHn/TH2
         u3tcmRidfdYolK6u2MxJVraQLAcNOgv3PmzdCZEFYh53sXI/PupQ8zBLw2KcFuc9KREz
         6kZQ==
X-Gm-Message-State: AOJu0YydgRKwVJtsIzH8XpRO2wCk0WfpCkxYdua6QUOnqTv6a4uZEAz7
        RV0h/8VxfkNQX6YFPu/NPKw=
X-Google-Smtp-Source: AGHT+IHBRbx8jLImJfC7ica558b3qW0zEigiiM5bHlYEC+vIITwgUSZjunLiks2PZyY62kXDDrItlA==
X-Received: by 2002:a05:620a:471e:b0:778:b352:5f0c with SMTP id bs30-20020a05620a471e00b00778b3525f0cmr1180742qkb.28.1698786720511;
        Tue, 31 Oct 2023 14:12:00 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id k14-20020a0cc78e000000b0066d20f29e5fsm863424qvj.35.2023.10.31.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 14:12:00 -0700 (PDT)
Date:   Tue, 31 Oct 2023 17:11:59 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Lucas Karpinski <lkarpins@redhat.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <65416d9fc1024_bcdbc29418@willemb.c.googlers.com.notmuch>
In-Reply-To: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Lucas Karpinski wrote:
> The sockets used by udpgso_bench_tx aren't always ready when
> udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
> kernels, but can occur in both. Replace the hacky sleep calls with a
> function that checks whether the ports in the namespace are ready for
> use.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
> https://lore.kernel.org/all/t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp/
> 
> Changelog v2: 
> - applied synchronization method suggested by Pablo
> - changed commit message to code 
> 
>  tools/testing/selftests/net/udpgro.sh         | 27 ++++++++++++++-----
>  tools/testing/selftests/net/udpgro_bench.sh   | 19 +++++++++++--
>  tools/testing/selftests/net/udpgro_frglist.sh | 19 +++++++++++--
>  3 files changed, 54 insertions(+), 11 deletions(-)

The patch subject mentions UDP GSO, but the patch fixes the udpgro
scripts.

There are separate udpgso testcases. So you probably want to s/gso/gro.


> diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
> index 0c743752669a..04792a315729 100755
> --- a/tools/testing/selftests/net/udpgro.sh
> +++ b/tools/testing/selftests/net/udpgro.sh
> @@ -24,6 +24,22 @@ cleanup() {
>  }
>  trap cleanup EXIT
>  
> +wait_local_port_listen()
> +{
> +	local port="${1}"
> +
> +	local port_hex
> +	port_hex="$(printf "%04X" "${port}")"
> +
> +	local i
> +	for i in $(seq 10); do
> +		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
> +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&

Might a grep be shorter and more readable?

> +			break
> +		sleep 0.1
> +	done
> +}
> +
>  cfg_veth() {
>  	ip netns add "${PEER_NS}"
>  	ip -netns "${PEER_NS}" link set lo up
> @@ -51,8 +67,7 @@ run_one() {
>  		echo "ok" || \
>  		echo "failed" &
>  
> -	# Hack: let bg programs complete the startup
> -	sleep 0.2
> +	wait_local_port_listen 8000
>  	./udpgso_bench_tx ${tx_args}
>  	ret=$?
>  	wait $(jobs -p)
> @@ -97,7 +112,7 @@ run_one_nat() {
>  		echo "ok" || \
>  		echo "failed"&
>  
> -	sleep 0.1
> +	wait_local_port_listen 8000
>  	./udpgso_bench_tx ${tx_args}
>  	ret=$?
>  	kill -INT $pid
> @@ -118,11 +133,9 @@ run_one_2sock() {
>  		echo "ok" || \
>  		echo "failed" &
>  
> -	# Hack: let bg programs complete the startup
> -	sleep 0.2
> +	wait_local_port_listen 12345
>  	./udpgso_bench_tx ${tx_args} -p 12345
> -	sleep 0.1
> -	# first UDP GSO socket should be closed at this point
> +	wait_local_port_listen 8000
>  	./udpgso_bench_tx ${tx_args}
>  	ret=$?
>  	wait $(jobs -p)
> diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
> index 894972877e8b..91833518e80b 100755
> --- a/tools/testing/selftests/net/udpgro_bench.sh
> +++ b/tools/testing/selftests/net/udpgro_bench.sh
> @@ -16,6 +16,22 @@ cleanup() {
>  }
>  trap cleanup EXIT
>  
> +wait_local_port_listen()
> +{
> +	local port="${1}"
> +
> +	local port_hex
> +	port_hex="$(printf "%04X" "${port}")"
> +
> +	local i
> +	for i in $(seq 10); do
> +		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
> +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
> +			break
> +		sleep 0.1
> +	done
> +}
> +
>  run_one() {
>  	# use 'rx' as separator between sender args and receiver args
>  	local -r all="$@"
> @@ -40,8 +56,7 @@ run_one() {
>  	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
>  	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
>  
> -	# Hack: let bg programs complete the startup
> -	sleep 0.2
> +	wait_local_port_listen 8000
>  	./udpgso_bench_tx ${tx_args}
>  }
>  
> diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
> index 0a6359bed0b9..0aa2068f122c 100755
> --- a/tools/testing/selftests/net/udpgro_frglist.sh
> +++ b/tools/testing/selftests/net/udpgro_frglist.sh
> @@ -16,6 +16,22 @@ cleanup() {
>  }
>  trap cleanup EXIT
>  
> +wait_local_port_listen()
> +{
> +	local port="${1}"
> +
> +	local port_hex
> +	port_hex="$(printf "%04X" "${port}")"
> +
> +	local i
> +	for i in $(seq 10); do
> +		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
> +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
> +			break
> +		sleep 0.1
> +	done
> +}
> +
>  run_one() {
>  	# use 'rx' as separator between sender args and receiver args
>  	local -r all="$@"
> @@ -45,8 +61,7 @@ run_one() {
>          echo ${rx_args}
>  	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
>  
> -	# Hack: let bg programs complete the startup
> -	sleep 0.2
> +	wait_local_port_listen 8000
>  	./udpgso_bench_tx ${tx_args}
>  }
>  
> -- 
> 2.41.0
> 


