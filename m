Return-Path: <linux-kselftest+bounces-38070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B6B1561E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 01:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DED15A19FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 23:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F257213E66;
	Tue, 29 Jul 2025 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6DLbujK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB22AE90;
	Tue, 29 Jul 2025 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832730; cv=none; b=FSLohcOTmtmGvoocfvAibGZBSl/iNFvWZiw84cYy/ROzEOB/sX7dP6aB2ETy/BtFptUsqs8EW8cpwlAXJhMueaT9KSkR9DtNhO0UO195uVhPCwIqcss1TryVhRsvPuqFEdrmKN/QYQxi2aIlUbYLsnqKkTGp99qv0MydrwhX0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832730; c=relaxed/simple;
	bh=hHkDg3Mtor7U7Fgnz0VPldH2YUiM8ke7GMdPtNrE6yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1nomP/d5gcB0idoLggI8fGsX4dqo0XdnUrUTebrlBpAy4LmsIa/gVAf93+ECQPOQcGf3gRRiywfRxfcSQcsrOgN735J7CCMaVEli/XoinMZJ9x4EXx8W5MgrZO11oAUBewEiRjROfk9eUwa9FwCLhrF7xfXuN+ELU3QmpFbcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6DLbujK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466A9C4CEEF;
	Tue, 29 Jul 2025 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832729;
	bh=hHkDg3Mtor7U7Fgnz0VPldH2YUiM8ke7GMdPtNrE6yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h6DLbujKpTNjSm7sCpCsI0XPJ5TGkxuUizs1UDqTYEHXOxF4Mjw/0JGmOEnxesD4y
	 SKtkkg2exeLsu8n2AZi5OW83EPOYZajowMG5mRShTSqEHF7txlH1yKU9nF7wsshAd/
	 R/eutjCqIQlLDhAOejdF0LyeOa9C4Jy5GvJ6BdjPpla7RQQGi89FQnwmodpnt6nz5P
	 cblYnexBWuYo/xRMYwVwzgNefERIWfmyieMdEJHxP1ecQmSQZnw2Cw/nQjusCBIy6l
	 OIkDQcPPh77NeqGmXBPJ7CbvCXH9eCaryIznoEuR87kZszYyWBKW/17SsXwXaLywxD
	 M8TnqfNY3zF3A==
Message-ID: <ad4c6ff2-afd3-48ce-b55b-c9ea51168c79@kernel.org>
Date: Tue, 29 Jul 2025 17:45:27 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 iproute2-next 1/1] tc: add dualpi2 scheduler module
Content-Language: en-US
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
 Oliver Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Henrik Steen <henrist@henrist.net>
References: <20250717232357.69185-1-chia-yu.chang@nokia-bell-labs.com>
 <20250717232357.69185-2-chia-yu.chang@nokia-bell-labs.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250717232357.69185-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 5:23 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index 958d9407..15d1a37a 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h

you can drop the uapi changes.

> diff --git a/include/utils.h b/include/utils.h
> index 9a81494d..91e6e31f 100644
> --- a/include/utils.h
> +++ b/include/utils.h
> @@ -146,6 +146,8 @@ int read_prop(const char *dev, char *prop, long *value);
>  int get_long(long *val, const char *arg, int base);
>  int get_integer(int *val, const char *arg, int base);
>  int get_unsigned(unsigned *val, const char *arg, int base);
> +int get_float(float *val, const char *arg);
> +int get_float_min_max(float *val, const char *arg, float min, float max);
>  int get_time_rtt(unsigned *val, const char *arg, int *raw);
>  #define get_byte get_u8
>  #define get_ushort get_u16
> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
> index fcffa852..9f6084e6 100644
> --- a/ip/iplink_can.c
> +++ b/ip/iplink_can.c
> @@ -67,20 +67,6 @@ static void usage(void)
>  	print_usage(stderr);
>  }
>  
> -static int get_float(float *val, const char *arg)
> -{
> -	float res;
> -	char *ptr;
> -
> -	if (!arg || !*arg)
> -		return -1;
> -	res = strtof(arg, &ptr);
> -	if (!ptr || ptr == arg || *ptr)
> -		return -1;
> -	*val = res;
> -	return 0;
> -}
> -
>  static void set_ctrlmode(char *name, char *arg,
>  			 struct can_ctrlmode *cm, __u32 flags)
>  {
> diff --git a/lib/utils.c b/lib/utils.c
> index 706e93c3..dd242d4d 100644
> --- a/lib/utils.c
> +++ b/lib/utils.c
> @@ -220,6 +220,36 @@ int get_unsigned(unsigned int *val, const char *arg, int base)
>  	return 0;
>  }
>  
> +int get_float(float *val, const char *arg)
> +{
> +	float res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtof(arg, &ptr);
> +	if (!ptr || ptr == arg || *ptr)
> +		return -1;
> +	*val = res;
> +	return 0;
> +}

Put the move of get_float in a standlone patch indicating it is a code
move.


> +
> +int get_float_min_max(float *val, const char *arg, float min, float max)
> +{
> +	float res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtof(arg, &ptr);
> +	if (!ptr || ptr == arg || *ptr)
> +		return -1;
> +	if (res < min || res > max)
> +		return -1;
> +	*val = res;
> +	return 0;
> +}
> +
>  /*
>   * get_time_rtt is "translated" from a similar routine "get_time" in
>   * tc_util.c.  We don't use the exact same routine because tc passes

Add get_float_min_max in a standalone patch.



> diff --git a/tc/q_dualpi2.c b/tc/q_dualpi2.c
> new file mode 100644
> index 00000000..50d52aad
> --- /dev/null
> +++ b/tc/q_dualpi2.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +/* Copyright (C) 2024 Nokia
> + *
> + * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> + * Author: Olga Albisser <olga@albisser.org>
> + * Author: Henrik Steen <henrist@henrist.net>
> + * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
> + * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> + *
> + * DualPI Improved with a Square (dualpi2):
> + * - Supports congestion controls that comply with the Prague requirements
> + *   in RFC9331 (e.g. TCP-Prague)
> + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> + * - Supports ECN L4S-identifier (IP.ECN==0b*1)
> + *
> + * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
> + *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
> + *   Section 4, so they can only be used with DualPI2 in a datacenter
> + *   context.
> + *
> + * References:
> + * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
> + * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
> + *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <syslog.h>
> +#include <fcntl.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>
> +#include <math.h>
> +#include <errno.h>
> +
> +#include "utils.h"
> +#include "tc_util.h"
> +
> +#define MAX_PROB ((uint32_t)(~0U))
> +#define DEFAULT_ALPHA_BETA ((uint32_t)(~0U))
> +#define ALPHA_BETA_MAX ((2 << 23) - 1) /* see net/sched/sch_dualpi2.c */
> +#define ALPHA_BETA_SCALE (1 << 8)
> +#define RTT_TYP_TO_MAX 6
> +
> +static const char *get_credit_queue(int credit)
> +{
> +	return credit > 0 ? "C-queue" : "L-queue";
> +}
> +
> +static const char *get_ecn_type(uint8_t ect)
> +{
> +	switch (ect & TC_DUALPI2_ECN_MASK_ANY_ECT) {
> +	case TC_DUALPI2_ECN_MASK_L4S_ECT: return "l4s_ect";
> +	case TC_DUALPI2_ECN_MASK_CLA_ECT:
> +	case TC_DUALPI2_ECN_MASK_ANY_ECT: return "any_ect";
> +	default:
> +		fprintf(stderr,
> +			"Warning: Unexpected ecn type %u!\n", ect);
> +		return "";
> +	}
> +}
> +
> +static const char *get_ecn_type_json(uint8_t ect)
> +{
> +	switch (ect & TC_DUALPI2_ECN_MASK_ANY_ECT) {
> +	case TC_DUALPI2_ECN_MASK_L4S_ECT: return "l4s-ect";
> +	case TC_DUALPI2_ECN_MASK_CLA_ECT:
> +	case TC_DUALPI2_ECN_MASK_ANY_ECT: return "any-ect";
> +	default:
> +		fprintf(stderr,
> +			"Warning: Unexpected ecn type %u!\n", ect);
> +		return "";
> +	}
> +}
> +
> +static void explain(void)
> +{
> +	fprintf(stderr, "Usage: ... dualpi2\n");
> +	fprintf(stderr, "               [limit PACKETS]\n");
> +	fprintf(stderr, "               [memlimit BYTES]\n");
> +	fprintf(stderr, "               [coupling_factor NUMBER]\n");
> +	fprintf(stderr, "               [step_thresh TIME|PACKETS]\n");
> +	fprintf(stderr, "               [min_qlen_step PACKETS]\n");
> +	fprintf(stderr, "               [drop_on_overload|overflow]\n");
> +	fprintf(stderr, "               [drop_enqueue|drop_dequeue]\n");
> +	fprintf(stderr, "               [classic_protection PERCENTAGE]\n");
> +	fprintf(stderr, "               [max_rtt TIME [typical_rtt TIME]]\n");
> +	fprintf(stderr, "               [target TIME] [tupdate TIME]\n");
> +	fprintf(stderr, "               [alpha ALPHA] [beta BETA]\n");
> +	fprintf(stderr, "               [split_gso|no_split_gso]\n");
> +}
> +
> +static int get_packets(uint32_t *val, const char *arg)
> +{
> +	unsigned long res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtoul(arg, &ptr, 10);
> +	if (!ptr || ptr == arg ||
> +	    !(matches(ptr, "pkts") == 0 || matches(ptr, "packets") == 0))

we are not allowing any more uses of "matches".


> +		return -1;
> +	if (res == ULONG_MAX && errno == ERANGE)
> +		return -1;
> +	if (res > 0xFFFFFFFFUL)
> +		return -1;
> +	*val = res;
> +
> +	return 0;
> +}
> +
> +static int parse_alpha_beta(const char *name, char *argv, uint32_t *field)
> +{
> +
> +	float field_f;
> +
> +	if (get_float_min_max(&field_f, argv, 0.0, ALPHA_BETA_MAX)) {
> +		fprintf(stderr, "Illegal \"%s\"\n", name);
> +		return -1;
> +	} else if (field_f < 1.0f / ALPHA_BETA_SCALE)
> +		fprintf(stderr,
> +			"Warning: \"%s\" is too small and will be rounded to zero.\n",
> +			name);
> +	*field = (uint32_t)(field_f * ALPHA_BETA_SCALE);
> +
> +	return 0;
> +}
> +
> +static int try_get_percent(int *val, const char *arg)
> +{
> +	double per;
> +
> +	if (parse_percent(&per, arg))
> +		return -1;
> +
> +	*val = rint(per * 100);
> +
> +	return 0;
> +}
> +
> +static int dualpi2_parse_opt(const struct qdisc_util *qu, int argc,
> +			     char **argv, struct nlmsghdr *n, const char *dev)
> +{
> +	uint32_t limit = 0;
> +	uint32_t memory_limit = 0;
> +	uint32_t target = 0;
> +	uint32_t tupdate = 0;
> +	uint32_t alpha = DEFAULT_ALPHA_BETA;
> +	uint32_t beta = DEFAULT_ALPHA_BETA;
> +	int32_t coupling_factor = -1;
> +	uint8_t ecn_mask = 0;
> +	int step_unit = __TCA_DUALPI2_MAX;
> +	uint32_t step_thresh = 0;
> +	uint32_t min_qlen_step =  0;
> +	bool set_min_qlen_step = false;
> +	int c_protection = -1;
> +	uint8_t drop_early = __TCA_DUALPI2_DROP_EARLY_MAX;
> +	uint8_t drop_overload = __TCA_DUALPI2_DROP_OVERLOAD_MAX;
> +	uint8_t split_gso = __TCA_DUALPI2_SPLIT_GSO_MAX;
> +	uint32_t rtt_max = 0;
> +	uint32_t rtt_typ = 0;
> +	struct rtattr *tail;

iproute2 follows kernel coding standards and netdev's preference for
reverse xmas tree listing of variables.


