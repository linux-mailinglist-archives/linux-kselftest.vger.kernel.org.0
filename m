Return-Path: <linux-kselftest+bounces-40787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD4B440C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2638D1660C7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D25627F00A;
	Thu,  4 Sep 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz0XGNUL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42B274B37;
	Thu,  4 Sep 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000177; cv=none; b=BAgUj21N2EfP8dh6/UeCtYBKK58bF9JtrImtUculGBxiDzjavu7vITVi5Gqp0KR6L2RQ+1qxKPe3qPsLPgMssxpLc0QV+GlRs/mSWwiwKZOXIqjNKf8cKGoipYyuETpy2yf25eOY2Bsv3vKfT5/x41sT+8/ZXJO51AqDlcO29tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000177; c=relaxed/simple;
	bh=Zhh+/A9kJtldiBdmzD/Y+hpgYjPTJskTjHqrI3X31TM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bIF4WEaVQ9QTyC6nSJ1nTC49guaLbZ3LL7tiCdM1Ov1HZ4VNtul+5tDE/Gm0n9BQo6t5QeHUb6KTygARzC0s3q3+1m+mNmcpuckDwpxEsngqpypVP1WnqIgR440m5ShKlN6y+vKc1HK+ie//T0UZJVvh+mFTD0dUiomQZJa1BW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz0XGNUL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7f04816589bso117083885a.3;
        Thu, 04 Sep 2025 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757000174; x=1757604974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbuSI1OlZ+wbAUYqL8HDadi/6F37Rp4puRFTgu+g04I=;
        b=Bz0XGNULofM2ECEkRP7yGiZ03R4zmuxQvhX2QsWS8Dz+AUCtLJjvV3QTSD+cFKf1Xb
         9Hb/f28DV1pfVoVXbKBpjtLsmCKbsGno4KHmECHNkC53yiZsOKqiMJm180VwK0awg6sB
         jA1tuJXDLqpc22dq3BlZxoUItp7Q7z5Q1efEmG/gkPCjWv34CzFRtioEFy8TD9u+msFM
         0gJ5T+vBb89MKiVw4EYiHxNxatpw5EUYExhMCkgNpTmB7zccIFQGSVXwQwq9vktJAcwQ
         x/LANxxauXZjNUsKGBuhqQonADUTxrpQ8KstoRvvryJgtZOA4gJ/L36NEXqupQ1b1YaE
         s/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757000174; x=1757604974;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FbuSI1OlZ+wbAUYqL8HDadi/6F37Rp4puRFTgu+g04I=;
        b=rjIlppC+7i0NW0Mg2jLllKxUAUasGG+GFlFFY6nWv/aorK7gvMSthArM0ZyI+Q8sqS
         14V3t6jBTAtaKm2tPVu0vvS7Q6oORoDsJS52VgF9q3EVEs+/YjnsROluKnVmjS4HEVLD
         V2qP9DeF/T5KQVZUbX9AjsHpXkiBQrpO7JsEpoOQU+A+I87CO3moO1VO0Iw3T4Gfje8N
         uSpXUaHeU4uSCmrmhdhjevtBgxqSbBicQ5pznueb/VkyiceaV3d18EnVVonGkzSgqm1X
         jpAaf8TxDLphQHRmUqVKGuAS0VXf+M59UTY8xxPbyno8gR7EjTa2MKHJkQ4ELwyTY5Fq
         ED4g==
X-Forwarded-Encrypted: i=1; AJvYcCWMygYtqogbdhBq+0ynXaDunXBiKUa0Y7b6R7s/6NGG9ITt78Xxoe65UgeaP4SkqA7mCeU39DLV@vger.kernel.org, AJvYcCWYIVrbUNdTWDX74dJE5giXkKp5yuQN7UP/ECTEF0MrJmcZS2BbzWkIooMTLHgc/P1DXEPgWCjc24z5y9b4lK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9oBD3xE87buVMIlfxQWQ4XgJMyALGiyuoBSJjlbxoXK1wzMd
	AHKbWp0El+81IoA8L5xWWFjVT1LNxEuJk6dl9ieSMmFwR6PCbPQXD/dm
X-Gm-Gg: ASbGnctAiEzobU7nHSwmR6vBue0zNuVBeWVkeBts5OP9y+NrxavDeN7G5A16mY3HZFX
	LyR6Zeu9sSPIiqa3PvSE7KKoTyNhfMbNQKJvpbHvy+cTrm9p+vBRP/tk9DkrLtQn3aMXynS01MF
	B2ddzDFKfGc67uXv9ZG1BmYj0OgfzVUj6YeqellMt/qiCf7HQ+GskNDMJevTk80lDzgLVEn98Al
	6PXrmBN3AGm6A9P6FoRT1KPSp4zd2VxeW312JxnKqWpiinx06vE6LlWJfd4CefynC3oHJUugpGM
	ggFwFW5gvsDfntxR3IQBR/sV7mK97neEXtbSMzfTs1U+eBUsypQp/VrULNoxLm4nYDoiQK9Lpx0
	mV9Rd3qMISDCMLIkzbNeEWS+hvJ5fmXNKK/hFzeGnoE3fVm1Q8gRayYMkm+S1vcCIoftri3npji
	K02BJVd38ZOreC
X-Google-Smtp-Source: AGHT+IEUWEXialSoqxANvjGbEt3w97Qry/VSdQePFuCRtV3f3z4eKdLOAvK1JELh20Zu2eyARMKewA==
X-Received: by 2002:a05:620a:4490:b0:810:919c:ed26 with SMTP id af79cd13be357-810919ced77mr28805185a.29.1757000173567;
        Thu, 04 Sep 2025 08:36:13 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b48f7823casm30749311cf.42.2025.09.04.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:36:13 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:36:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marc Harvey <marcharvey@google.com>, 
 jiri@resnulli.us, 
 andrew+netdev@lunn.ch
Cc: edumazet@google.com, 
 willemb@google.com, 
 maheshb@google.com, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kuba@kernel.org, 
 liuhangbin@gmail.com, 
 Marc Harvey <marcharvey@google.com>
Message-ID: <willemdebruijn.kernel.22c2bf5d2d4f3@gmail.com>
In-Reply-To: <20250904015424.1228665-1-marcharvey@google.com>
References: <20250904015424.1228665-1-marcharvey@google.com>
Subject: Re: [PATCH net-next v2] selftests: net: Add tests to verify team
 driver option set and get.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marc Harvey wrote:
> There are currently no kernel tests that verify setting and getting
> options of the team driver.
> 
> In the future, options may be added that implicitly change other
> options, which will make it useful to have tests like these that show
> nothing breaks. There will be a follow up patch to this that adds new
> "rx_enabled" and "tx_enabled" options, which will implicitly affect the
> "enabled" option value and vice versa.
> 
> The tests use teamnl to first set options to specific values and then
> gets them to compare to the set values.
> 
> Signed-off-by: Marc Harvey <marcharvey@google.com>
> ---
> Changes in v2:
>   - Fixed shellcheck failures.
>   - Fixed test failing in vng by adding a config option to enable the
>     team driver's active backup mode.
>   - Link to v1: https://lore.kernel.org/netdev/20250902235504.4190036-1-marcharvey@google.com/
> 
>  .../selftests/drivers/net/team/Makefile       |   6 +-
>  .../testing/selftests/drivers/net/team/config |   1 +
>  .../selftests/drivers/net/team/options.sh     | 192 ++++++++++++++++++
>  3 files changed, 197 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/team/options.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
> index eaf6938f100e..8b00b70ce67f 100644
> --- a/tools/testing/selftests/drivers/net/team/Makefile
> +++ b/tools/testing/selftests/drivers/net/team/Makefile
> @@ -1,11 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for net selftests
>  
> -TEST_PROGS := dev_addr_lists.sh propagation.sh
> +TEST_PROGS := dev_addr_lists.sh propagation.sh options.sh
>  
>  TEST_INCLUDES := \
>  	../bonding/lag_lib.sh \
>  	../../../net/forwarding/lib.sh \
> -	../../../net/lib.sh
> +	../../../net/lib.sh \
> +	../../../net/in_netns.sh \
> +	../../../net/lib/sh/defer.sh \

Where is defer used? Also no backslash at last line.
>  
>  include ../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/team/config b/tools/testing/selftests/drivers/net/team/config
> index 636b3525b679..558e1d0cf565 100644
> --- a/tools/testing/selftests/drivers/net/team/config
> +++ b/tools/testing/selftests/drivers/net/team/config
> @@ -3,4 +3,5 @@ CONFIG_IPV6=y
>  CONFIG_MACVLAN=y
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_TEAM=y
> +CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
>  CONFIG_NET_TEAM_MODE_LOADBALANCE=y
> diff --git a/tools/testing/selftests/drivers/net/team/options.sh b/tools/testing/selftests/drivers/net/team/options.sh
> new file mode 100755
> index 000000000000..82bf22aa3480
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/team/options.sh
> @@ -0,0 +1,192 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# These tests verify basic set and get functionality of the team
> +# driver options over netlink.
> +
> +# Run in private netns.
> +test_dir="$(dirname "$0")"
> +if [[ $# -eq 0 ]]; then
> +        "${test_dir}"/../../../net/in_netns.sh "$0" __subprocess
> +        exit $?
> +fi
> +
> +ALL_TESTS="
> +        team_test_options
> +"
> +
> +source "${test_dir}/../../../net/lib.sh"
> +
> +TEAM_PORT="team0"
> +MEMBER_PORT="dummy0"
> +
> +setup()
> +{
> +        ip link add name "${MEMBER_PORT}" type dummy
> +        ip link add name "${TEAM_PORT}" type team
> +}
> +
> +get_and_check_value()
> +{
> +        local option_name="$1"
> +        local expected_value="$2"
> +        local port_flag="$3"
> +
> +        local value_from_get
> +
> +        if ! value_from_get=$(teamnl "${TEAM_PORT}" getoption "${option_name}" \
> +                        "${port_flag}"); then
> +                echo "Could not get option '${option_name}'" >&2
> +                return 1
> +        fi
> +
> +        if [[ "${value_from_get}" != "${expected_value}" ]]; then
> +                echo "Incorrect value for option '${option_name}'" >&2
> +                echo "get (${value_from_get}) != set (${expected_value})" >&2
> +                return 1
> +        fi
> +}
> +
> +set_and_check_get()
> +{
> +        local option_name="$1"
> +        local option_value="$2"
> +        local port_flag="$3"
> +
> +        local value_from_get
> +
> +        if ! teamnl "${TEAM_PORT}" setoption "${option_name}" "${option_value}" \
> +                        "${port_flag}"; then
> +                echo "'setoption ${option_name} ${option_value}' failed" >&2
> +                return 1
> +        fi
> +
> +        get_and_check_value "${option_name}" "${option_value}" "${port_flag}"
> +        return $?
> +}
> +
> +# Get a "port flag" to pass to the `teamnl` command.
> +# E.g. $1="dummy0" -> "port=dummy0",
> +#      $1=""       -> ""
> +get_port_flag()
> +{
> +        local port_name="$1"
> +
> +        if [[ -n "${port_name}" ]]; then
> +                echo "--port=${port_name}"
> +        fi
> +}
> +
> +attach_port_if_specified()
> +{
> +        local port_name="${1}"

nit: parentheses around single character variable. Inconsistent.

> +
> +        if [[ -n "${port_name}" ]]; then
> +                ip link set dev "${port_name}" master "${TEAM_PORT}"
> +                return $?
> +        fi
> +}
> +
> +detach_port_if_specified()
> +{
> +        local port_name="${1}"
> +
> +        if [[ -n "${port_name}" ]]; then
> +                ip link set dev "${port_name}" nomaster
> +                return $?
> +        fi
> +}
> +
> +#######################################
> +# Test that an option's get value matches its set value.
> +# Globals:
> +#   RET - Used by testing infra like `check_err`.
> +#   EXIT_STATUS - Used by `log_test` to whole script exit value.
> +# Arguments:
> +#   option_name - The name of the option.
> +#   value_1 - The first value to try setting.
> +#   value_2 - The second value to try setting.
> +#   port_name - The (optional) name of the attached port.
> +#######################################

Just curious: is this a standard documentation format?

> +team_test_option()
> +{
> +        local option_name="$1"
> +        local value_1="$2"
> +        local value_2="$3"
> +        local possible_values="$2 $3 $2"
> +        local port_name="$4"
> +        local port_flag
> +
> +        RET=0
> +
> +        echo "Setting '${option_name}' to '${value_1}' and '${value_2}'"
> +
> +        attach_port_if_specified "${port_name}"
> +        check_err $? "Couldn't attach ${port_name} to master"

Can the rest of the test continue if this command failed?

> +        port_flag=$(get_port_flag "${port_name}")
> +
> +        # Set and get both possible values.
> +        for value in ${possible_values}; do
> +                set_and_check_get "${option_name}" "${value}" "${port_flag}"
> +                check_err $? "Failed to set '${option_name}' to '${value}'"
> +        done
> +
> +        detach_port_if_specified "${port_name}"
> +        check_err $? "Couldn't detach ${port_name} from its master"
> +
> +        log_test "Set + Get '${option_name}' test"
> +}


