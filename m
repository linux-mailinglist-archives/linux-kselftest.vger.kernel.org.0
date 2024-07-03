Return-Path: <linux-kselftest+bounces-13103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F592528B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549F41C20ABD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 04:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24B28DCB;
	Wed,  3 Jul 2024 04:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYumPuD8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1792629C;
	Wed,  3 Jul 2024 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981642; cv=none; b=QzLt3NHNIAvdSmQLMH7qMom04eESHpBo1Lc7zxWsvSCbsWKcVoHeprnyAVDNvoV9AwvQJiWcfV21J/2PINE6r40UvFkNgQLQgVp9DvClopFZ+pPkPcsuv1ohc/QbM0Cal23PX6tepIxD4RdFBImLteDh7Met/+mN0NaJa4fkTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981642; c=relaxed/simple;
	bh=nCTE4WkhNUPPILDxqTwxVagjco8cu0g9bpjojvAeHX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7NF6lqfiQEwdbl0hNLBq7sKGz22mbrTXNhFh/613SkoIa+aVmweF9hZn2jrve7J4UkSQsVyBLaZuGTeHOYDBA9F2FJeI+bvm3D5OcdiPG/PxbsEY5eYpUO/HL3pow331LtT4Oyo7G44Z3pm/OPl+2BOm8GeRm0tLfoPMZmRvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYumPuD8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719981641; x=1751517641;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nCTE4WkhNUPPILDxqTwxVagjco8cu0g9bpjojvAeHX0=;
  b=dYumPuD8N1onzx0i7h8RRVlRhoMl+nvcBqjfNCsU1XLSICDCPxRvjpQW
   LngtPrlQB2GGt3NkIIggqKyKs7mE2PhRGoBQRTsT2guiHW3rrhWhDHpyn
   mOYvNXuSER5wPMvo6/+NS5p1OJMboBMpeZdRsRzZd4fLdG8bsKZQ7/mvi
   tty55fU8mFb/vONzzyjy5os8XNUb2db3fT8/tgyneMwM8IapzemHptpld
   ei1QyU0vJ9tUWkb87W1+3KeTd5oSREyUTnKNWxMVnTGTYuF7D8cDAvGL+
   D1xpnRZYWVnJvheknFtO8oFzTJhKcU9rtHuBK8lSVwGrSvsOEDpPAurSa
   Q==;
X-CSE-ConnectionGUID: fvAAmDg2T52MqzRK/++RpQ==
X-CSE-MsgGUID: ivbNsKPXQ4au0VDkB3/0Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28322493"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28322493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 21:40:41 -0700
X-CSE-ConnectionGUID: lpDjo6x2QIK9tWsX/clakQ==
X-CSE-MsgGUID: Mh6NxwWkQCa3oLmX16G52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="50575620"
Received: from unknown (HELO [10.247.172.64]) ([10.247.172.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 21:40:37 -0700
Message-ID: <7142312c6a9e2aa96134031be435448c56d1897e.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] selftests/thermel/intel: conform the test to TAP
 output
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 02 Jul 2024 21:40:33 -0700
In-Reply-To: <20240702101259.1251377-2-usama.anjum@collabora.com>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
	 <20240702101259.1251377-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 15:12 +0500, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output
> messages.
>=20
Not true. You did functional change by adding a break in the loop.
The purpose here to wait for these message continuously till ctrl-c or
similar.

> The test has infinite loop to read the value of status_str. Break the
> loop after getting the value once and finish the test.
>=20
No, that is not the purpose.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use ksft_exit_fail_perror if read() returns error
> - Break the infinite loop after printing status_str
> ---
> =C2=A0.../intel/power_floor/power_floor_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 70 ++++++++---------
> --
> =C2=A01 file changed, 30 insertions(+), 40 deletions(-)
>=20
> diff --git
> a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
> c
> b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
> c
> index 0326b39a11b91..c06b275acd36b 100644
> ---
> a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
> c
> +++
> b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.
> c
> @@ -9,6 +9,7 @@
> =C2=A0#include <fcntl.h>
> =C2=A0#include <poll.h>
> =C2=A0#include <signal.h>
> +#include "../../../kselftest.h"
> =C2=A0
> =C2=A0#define POWER_FLOOR_ENABLE_ATTRIBUTE
> "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_enable"
> =C2=A0#define POWER_FLOOR_STATUS_ATTRIBUTE=C2=A0
> "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_status"
> @@ -20,17 +21,13 @@ void power_floor_exit(int signum)
> =C2=A0	/* Disable feature via sysfs knob */
> =C2=A0
> =C2=A0	fd =3D open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
> -	if (fd < 0) {
> -		perror("Unable to open power floor enable file\n");
> -		exit(1);
> -	}
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Unable to open power floor
> enable file");
> =C2=A0
> -	if (write(fd, "0\n", 2) < 0) {
> -		perror("Can' disable power floor notifications\n");
> -		exit(1);
> -	}
> +	if (write(fd, "0\n", 2) < 0)
> +		ksft_exit_fail_perror("Can' disable power floor
> notifications");
> =C2=A0
> -	printf("Disabled power floor notifications\n");
> +	ksft_print_msg("Disabled power floor notifications\n");
> =C2=A0
> =C2=A0	close(fd);
> =C2=A0}
> @@ -41,6 +38,9 @@ int main(int argc, char **argv)
> =C2=A0	char status_str[3];
> =C2=A0	int fd, ret;
> =C2=A0
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> =C2=A0	if (signal(SIGINT, power_floor_exit) =3D=3D SIG_IGN)
> =C2=A0		signal(SIGINT, SIG_IGN);
> =C2=A0	if (signal(SIGHUP, power_floor_exit) =3D=3D SIG_IGN)
> @@ -50,59 +50,49 @@ int main(int argc, char **argv)
> =C2=A0
> =C2=A0	/* Enable feature via sysfs knob */
> =C2=A0	fd =3D open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
> -	if (fd < 0) {
> -		perror("Unable to open power floor enable file\n");
> -		exit(1);
> -	}
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Unable to open power floor
> enable file");
> =C2=A0
> -	if (write(fd, "1\n", 2) < 0) {
> -		perror("Can' enable power floor notifications\n");
> -		exit(1);
> -	}
> +	if (write(fd, "1\n", 2) < 0)
> +		ksft_exit_fail_perror("Can' enable power floor
> notifications");
> =C2=A0
> =C2=A0	close(fd);
> =C2=A0
> -	printf("Enabled power floor notifications\n");
> +	ksft_print_msg("Enabled power floor notifications\n");
> =C2=A0
> =C2=A0	while (1) {
> =C2=A0		fd =3D open(POWER_FLOOR_STATUS_ATTRIBUTE, O_RDONLY);
> -		if (fd < 0) {
> -			perror("Unable to power floor status
> file\n");
> -			exit(1);
> -		}
> +		if (fd < 0)
> +			ksft_exit_fail_perror("Unable to power floor
> status file");
> =C2=A0
> -		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> -			fprintf(stderr, "Failed to set pointer to
> beginning\n");
> -			exit(1);
> -		}
> +		if ((lseek(fd, 0L, SEEK_SET)) < 0)
> +			ksft_exit_fail_perror("Failed to set pointer
> to beginning\n");
> =C2=A0
> -		if (read(fd, status_str, sizeof(status_str)) < 0) {
> -			fprintf(stderr, "Failed to read from:%s\n",
> -			POWER_FLOOR_STATUS_ATTRIBUTE);
> -			exit(1);
> -		}
> +		if (read(fd, status_str, sizeof(status_str)) < 0)
> +			ksft_exit_fail_perror("Failed to read from:
> power_floor_status");
> =C2=A0
> =C2=A0		ufd.fd =3D fd;
> =C2=A0		ufd.events =3D POLLPRI;
> =C2=A0
> =C2=A0		ret =3D poll(&ufd, 1, -1);
> =C2=A0		if (ret < 0) {
> -			perror("poll error");
> -			exit(1);
> +			ksft_exit_fail_msg("Poll error\n");
> =C2=A0		} else if (ret =3D=3D 0) {
> -			printf("Poll Timeout\n");
> +			ksft_print_msg("Poll Timeout\n");
> =C2=A0		} else {
> -			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> -				fprintf(stderr, "Failed to set
> pointer to beginning\n");
> -				exit(1);
> -			}
> +			if ((lseek(fd, 0L, SEEK_SET)) < 0)
> +				ksft_exit_fail_msg("Failed to set
> pointer to beginning\n");
> =C2=A0
> =C2=A0			if (read(fd, status_str, sizeof(status_str))
> < 0)
> -				exit(0);
> +				ksft_exit_fail_perror("Failed to
> read");
> =C2=A0
> -			printf("power floor status: %s\n",
> status_str);
> +			ksft_print_msg("power floor status: %s\n",
> status_str);
> +			break;
> =C2=A0		}
> =C2=A0
> =C2=A0		close(fd);
> =C2=A0	}
> +
> +	ksft_test_result_pass("Successfully read\n");
> +	ksft_finished();
> =C2=A0}


