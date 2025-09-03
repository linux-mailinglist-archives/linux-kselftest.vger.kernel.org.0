Return-Path: <linux-kselftest+bounces-40674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3506B41198
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 03:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFB189E248
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21733192B7D;
	Wed,  3 Sep 2025 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaSvF7Ya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8B6ADD
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861284; cv=none; b=Et9QoDRry2iTO0IH9GHWK83KfFfPTjGma6JrKjr23bk2uhoC98hPPXmutpgqwmHa0Lxfa3xwJmGU/IsHxANoUb8uHHxgAVe+ss8O2KTCgkH3vnXy//ek4rn8ZIOPDNZGOaJl83jC/We8W2OqIV+WXyZcThAR30dFzYD6gJtcKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861284; c=relaxed/simple;
	bh=eLxfhF7bXCU9jA/VGQSYK6FrKrYyNvjiNsfavzHX+g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sb0vBpGyJPNR4vN5WPpnNDOrSfasXR9Wqo7u8fzsrW2mB9zv1wIBKhIQkIRrW7oO0EpvbsG6YhSe7EaRro/SBIK64tyKXtBTs5G7f3fYMGVdWwFtTjKG5+5GyuuViCbfdo2ISmaKLE6udR8wxDnfJ7zor2zS79kHuA01V8+nrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaSvF7Ya; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so5232a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756861280; x=1757466080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prIHZgIMxeJu5kX8nscCgw6jHJBtQKuVxSzcsFq4qHA=;
        b=RaSvF7YabJD0u1rDr5VvK9g/u0KllHWfCFLBSlK1qUeNnh50yEUEzE4glhDppmJG6w
         gZaplkH4H7tlKOhcHPCYNbLE7LKGvTzC3A0djU8NjUFl4v2ITOVh9wNLjDvVYaVjmqpl
         3X7fuSTAL66pw1jftX+DsQgkLdCH4q5YGklw9a9oXrVNhkqlZ4MU58VAqx1+E+2SPc2y
         aH7QxzfnGgudc67CkTGLEG+Flj3dQ9o5FJcMQODG4a31P+lg4s2TjqTZn8Ejm+SuPjZo
         XpQBH0Elx8/XIC957mIeeK8W8g0p36UyC7DF4f9DG/kUoqoW6LNBncd/HZcmdE02gEOQ
         pcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756861280; x=1757466080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prIHZgIMxeJu5kX8nscCgw6jHJBtQKuVxSzcsFq4qHA=;
        b=XQfnrZBAJD/vLeYWgJdHJ9gVKpKvcmdioFpaxnBoMcp5+IsrKzGEBjNfQDMCPk8eTk
         p3Uxz8cpw1CVMVUyDL76yktW/FD976LZgvtjhw9YtbEpC7dLkmp1Qnsj41Kec/igk3YR
         BbtbbMyTwSE09xk1rcMY4nYP0CvSXTwJiV0qVHrxvPNO9Q/BpTq9zUzK4Ie7gDZ2fQRt
         vt68pd1vuIrSCT7fo2Rd/sVKtHWx3MpqfjXRptuVKO2qy9Eo3rfa3iG0NImbA/4bW8TW
         YOoBqtvWi4gGUWidO3LwFvgVLfA7SUiX+Z8TrUCTQJt3Uzwcb1MdxkWw+44ddQDznI2w
         7iMw==
X-Forwarded-Encrypted: i=1; AJvYcCWBMV+OWJ5dcum6ti20aUtf3Kw4wczoM7WNcxSk4PtRpl4N2NdpCEX+Ivzvw+IQmZLR6L4nsxFq832lXQ+Cu+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfFX8ylE58mVyKn1cr/VxNXf6Zvz+rimjtl1cuCl5bv97BA9N
	UGbsxUmUxOQjXWpVsyHxWQF5n2+5Bral4YC6T4n/J+4o/JcmnJqiqHWRfLz8T6TROc1d2u086Vw
	7NqlGSL4uXjSnRE1kabDt1zrHEHCLh0fF7yAVDlc6
X-Gm-Gg: ASbGncuBdq6qan5ZyaeC1AEiArCyLutN+StdoeVnqDt/KhEfJo4UVyhP03VUMRYrQe8
	DMpJ5o2nWkoUlAQOShLpJEVNRvXoiNvYLTrp+tNmUcN3GWNv7NovgWGrfEcgOH26XDS3PmNJX1Z
	RMV9YqV2SeOcwzIAfIQrn/Oxr237K36gky0+6VebgSg6B5GO3ebkgaedh2ZVQ0nun9hvDuq/DnB
	GgdWOPlnQoG5lEL+vSIQd6PIL5PAA1MzBxQ5RqheiRQ7qiF8uxyX4Uc+lGf0fGyMEseOo1l0SEW
	1uh9pJLTZwA=
X-Google-Smtp-Source: AGHT+IGn1ik1UlrKL/svGRoK0zBmPzkA9G5xalp5y5+CKZrF+WhYlbO1egi139cEOnIStGm6DznYYqjrEU42RAqcYe0=
X-Received: by 2002:a05:6402:a0d4:b0:61c:d709:ce04 with SMTP id
 4fb4d7f45d1cf-61d21f8f882mr372306a12.7.1756861280154; Tue, 02 Sep 2025
 18:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902235504.4190036-1-marcharvey@google.com>
In-Reply-To: <20250902235504.4190036-1-marcharvey@google.com>
From: Marc Harvey <marcharvey@google.com>
Date: Tue, 2 Sep 2025 18:01:09 -0700
X-Gm-Features: Ac12FXwBh67Bi6XAe_3VAULG_oaQy1aErOpWPtAnf-8Qp9WdlrOMMW2URu-tx5I
Message-ID: <CANkEMgnghooTAW-VqodTpwSUHicb6fb6c0mBi1vpxPHnSNQccg@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Add tests to verify team driver
 option set and get.
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: edumazet@google.com, willemb@google.com, maheshb@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:55=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
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
>  .../selftests/drivers/net/team/Makefile       |   6 +-
>  .../selftests/drivers/net/team/options.sh     | 194 ++++++++++++++++++
>  2 files changed, 198 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/team/options.sh
>
> diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/te=
sting/selftests/drivers/net/team/Makefile
> index eaf6938f100e..8b00b70ce67f 100644
> --- a/tools/testing/selftests/drivers/net/team/Makefile
> +++ b/tools/testing/selftests/drivers/net/team/Makefile
> @@ -1,11 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for net selftests
>
> -TEST_PROGS :=3D dev_addr_lists.sh propagation.sh
> +TEST_PROGS :=3D dev_addr_lists.sh propagation.sh options.sh
>
>  TEST_INCLUDES :=3D \
>         ../bonding/lag_lib.sh \
>         ../../../net/forwarding/lib.sh \
> -       ../../../net/lib.sh
> +       ../../../net/lib.sh \
> +       ../../../net/in_netns.sh \
> +       ../../../net/lib/sh/defer.sh \
>
>  include ../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/team/options.sh b/tools/=
testing/selftests/drivers/net/team/options.sh
> new file mode 100755
> index 000000000000..b9c7aa357ad5
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/team/options.sh
> @@ -0,0 +1,194 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# These tests verify basic set and get functionality of the team
> +# driver options over netlink.
> +
> +# Run in private netns.
> +test_dir=3D"$(dirname "$0")"
> +if [[ $# -eq 0 ]]; then
> +        "${test_dir}"/../../../net/in_netns.sh "$0" __subprocess
> +        exit $?
> +fi
> +
> +ALL_TESTS=3D"
> +        team_test_options
> +"
> +
> +source "${test_dir}/../../../net/lib.sh"
> +
> +TEAM_PORT=3D"team0"
> +MEMBER_PORT=3D"dummy0"
> +
> +setup()
> +{
> +        ip link add name "${MEMBER_PORT}" type dummy
> +        ip link add name "${TEAM_PORT}" type team
> +}
> +
> +get_and_check_value()
> +{
> +        local option_name=3D"$1"
> +        local expected_value=3D"$2"
> +        local port_flag=3D"$3"
> +
> +        local value_from_get
> +
> +        value_from_get=3D$(teamnl "${TEAM_PORT}" getoption "${option_nam=
e}" \
> +                "${port_flag}")
> +        if [[ $? !=3D 0 ]]; then

I'm aware of the shellcheck errors. Will wait to send v2 tomorrow for
the 24 hour rule.

> +                echo "Could not get option '${option_name}'" >&2
> +                return 1
> +        fi
> +
> +        if [[ "${value_from_get}" !=3D "${expected_value}" ]]; then
> +                echo "Incorrect value for option '${option_name}'" >&2
> +                echo "get (${value_from_get}) !=3D set (${expected_value=
})" >&2
> +                return 1
> +        fi
> +}
> +
> +set_and_check_get()
> +{
> +        local option_name=3D"$1"
> +        local option_value=3D"$2"
> +        local port_flag=3D"$3"
> +
> +        local value_from_get
> +
> +        teamnl "${TEAM_PORT}" setoption "${option_name}" "${option_value=
}" \
> +                "${port_flag}"
> +        if [[ $? !=3D 0 ]]; then
> +                echo "'setoption ${option_name} ${option_value}' failed"=
 >&2
> +                return 1
> +        fi
> +
> +        get_and_check_value "${option_name}" "${option_value}" "${port_f=
lag}"
> +        return $?
> +}
> +
> +# Get a "port flag" to pass to the `teamnl` command.
> +# E.g. $?=3D"dummy0" -> "port=3Ddummy0",
> +#      $?=3D""       -> ""
> +get_port_flag()
> +{
> +        local port_name=3D"$1"
> +
> +        if [[ -n "${port_name}" ]]; then
> +                echo "--port=3D${port_name}"
> +        fi
> +}
> +
> +attach_port_if_specified()
> +{
> +        local port_name=3D"${1}"
> +
> +        if [[ -n "${port_name}" ]]; then
> +                ip link set dev "${port_name}" master "${TEAM_PORT}"
> +                return $?
> +        fi
> +}
> +
> +detach_port_if_specified()
> +{
> +        local port_name=3D"${1}"
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
> +team_test_option()
> +{
> +        local option_name=3D"$1"
> +        local value_1=3D"$2"
> +        local value_2=3D"$3"
> +        local possible_values=3D"$2 $3 $2"
> +        local port_name=3D"$4"
> +        local port_flag
> +
> +        RET=3D0
> +
> +        echo "Setting '${option_name}' to '${value_1}' and '${value_2}'"
> +
> +        attach_port_if_specified "${port_name}"
> +        check_err $? "Couldn't attach ${port_name} to master"
> +        port_flag=3D$(get_port_flag "${port_name}")
> +
> +        # Set and get both possible values.
> +        for value in ${possible_values}; do
> +                set_and_check_get "${option_name}" "${value}" "${port_fl=
ag}"
> +                check_err $? "Failed to set '${option_name}' to '${value=
}'"
> +        done
> +
> +        detach_port_if_specified "${port_name}"
> +        check_err $? "Couldn't detach ${port_name} from its master"
> +
> +        log_test "Set + Get '${option_name}' test"
> +}
> +
> +#######################################
> +# Test that getting a non-existant option fails.
> +# Globals:
> +#   RET - Used by testing infra like `check_err`.
> +#   EXIT_STATUS - Used by `log_test` to whole script exit value.
> +# Arguments:
> +#   option_name - The name of the option.
> +#   port_name - The (optional) name of the attached port.
> +#######################################
> +team_test_get_option_fails()
> +{
> +        local option_name=3D"$1"
> +        local port_name=3D"$2"
> +        local port_flag
> +
> +        RET=3D0
> +
> +        attach_port_if_specified "${port_name}"
> +        check_err $? "Couldn't attach ${port_name} to master"
> +        port_flag=3D$(get_port_flag "${port_name}")
> +
> +        # Just confirm that getting the value fails.
> +        teamnl "${TEAM_PORT}" getoption "${option_name}" "${port_flag}"
> +        check_fail $? "Shouldn't be able to get option '${option_name}'"
> +
> +        detach_port_if_specified "${port_name}"
> +
> +        log_test "Get '${option_name}' fails"
> +}
> +
> +team_test_options()
> +{
> +        # Wrong option name behavior.
> +        team_test_get_option_fails fake_option1
> +        team_test_get_option_fails fake_option2 "${MEMBER_PORT}"
> +
> +        # Correct set and get behavior.
> +        team_test_option mode activebackup loadbalance
> +        team_test_option notify_peers_count 0 5
> +        team_test_option notify_peers_interval 0 5
> +        team_test_option mcast_rejoin_count 0 5
> +        team_test_option mcast_rejoin_interval 0 5
> +        team_test_option enabled true false "${MEMBER_PORT}"
> +        team_test_option user_linkup true false "${MEMBER_PORT}"
> +        team_test_option user_linkup_enabled true false "${MEMBER_PORT}"
> +        team_test_option priority 10 20 "${MEMBER_PORT}"
> +        team_test_option queue_id 0 1 "${MEMBER_PORT}"
> +}
> +
> +require_command teamnl
> +setup
> +tests_run
> +exit "${EXIT_STATUS}"
> --
> 2.51.0.355.g5224444f11-goog
>

