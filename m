Return-Path: <linux-kselftest+bounces-13125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 678CC9253E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 08:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7AA1F25164
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893B4965F;
	Wed,  3 Jul 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQysI965"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CEC134406;
	Wed,  3 Jul 2024 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989391; cv=none; b=reFrB0tflVw/nTJZ9fpc+KRFiQmIKVPuR0Z8FBEY22hFr4PRRyQjwaB8VzOg9H4wsdLLs8Bs46vFPCfDY5n7a+WH6suaXZgHanESFJgK/wo6AxvRW8ULnnDUn9t1t+7t/eP9PLCveWr8Sv4C1I+aDsP3Wg2QfowdJpS92cWON4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989391; c=relaxed/simple;
	bh=iN2AqTdth4nCx8As+C8g/nj3yQP/YNHgqi0OlXGQwm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UhY8Cghq3KIwiIvfzmha+dpe3F322V9JWb8ylSovt0iWJba0Pu+u5IvCEqJEfLlKMmGVoCFiQHpm2aya8jgAgYzYbldpjB0gegtMeM4YZKPPlCtfBVNZ5aPpesbZETOjoni25EVuuYYpaGWDIayYhQpHKt5Qay6ZpgzxH4dEKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQysI965; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719989390; x=1751525390;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iN2AqTdth4nCx8As+C8g/nj3yQP/YNHgqi0OlXGQwm4=;
  b=kQysI965uGbpYuSEmN/8862QcWNNdGrEiJeKFZyeP062jHl1o53O6uZK
   bsRNdK9sUwQeEYHvu/oyCxPiZkk2gAl/DeoLZRxErVODmCaiCYnVKDd64
   fhJ89zRv7J4tgu6NnEz76uxxtkt2yfue01CSp6MFaeJi3lwCJbXdHGHPA
   I0YjvkKe99vGX+Nvss6xAALuDoO1n/LZlIgg6XTC453ToABCuprrhNhLN
   sGnnb/e2HlAouB5Medz/LUheBU2tY09AZvGXTsuzvoOmJWdZ2xgbglnfl
   51u0OnBwvhdiKiGJbyoViVZ+2OorgI9plt/aoVqp6fs8CFVZJMUr3G7Rt
   w==;
X-CSE-ConnectionGUID: JUa2Wz72RayfQuUsAeN1MA==
X-CSE-MsgGUID: eN1RUZY4R2GawWDVoWmn0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17332454"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17332454"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:49:49 -0700
X-CSE-ConnectionGUID: w1+an81eSkSlznonJunz3w==
X-CSE-MsgGUID: 3SvXHzdnTp6fQ+rT7FlSBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46898986"
Received: from unknown (HELO [10.247.172.66]) ([10.247.172.66])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:49:46 -0700
Message-ID: <73344dcef12bbd3a4f6105af43531207f0f24dee.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] selftests/thermel/intel: conform the test to TAP
 output
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 02 Jul 2024 23:49:42 -0700
In-Reply-To: <81fe07bb-8980-4fca-950a-7945b6f8563a@collabora.com>
References: <20240702101259.1251377-1-usama.anjum@collabora.com>
	 <20240702101259.1251377-2-usama.anjum@collabora.com>
	 <7142312c6a9e2aa96134031be435448c56d1897e.camel@linux.intel.com>
	 <81fe07bb-8980-4fca-950a-7945b6f8563a@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 11:19 +0500, Muhammad Usama Anjum wrote:
> On 7/3/24 9:40 AM, srinivas pandruvada wrote:
> > On Tue, 2024-07-02 at 15:12 +0500, Muhammad Usama Anjum wrote:
> > > Conform the layout, informational and status messages to TAP. No
> > > functional change is intended other than the layout of output
> > > messages.
> > >=20
> > Not true. You did functional change by adding a break in the loop.
> > The purpose here to wait for these message continuously till ctrl-c
> > or
> > similar.
> I'll correct the description.
>=20
> >=20
> > > The test has infinite loop to read the value of status_str. Break
> > > the
> > > loop after getting the value once and finish the test.
> > >=20
> > No, that is not the purpose.
> We want to finish the test after some iterations as in CIs we cannot
> abort
> the test by sending signals. Would 10 or 100 iterations be enough for
> this
> test? Or it is the kind of test which wouldn't get events until some
> other
> process is using the same driver files?
>=20
You generate events, you need to do workload and reduce power limit to
trigger. Otherwise these are rare events.

Thanks,
Srinivas


> >=20
> > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > ---
> > > Changes since v1:
> > > - Use ksft_exit_fail_perror if read() returns error
> > > - Break the infinite loop after printing status_str
> > > ---
> > > =C2=A0.../intel/power_floor/power_floor_test.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 70 ++++++++-----
> > > ----
> > > --
> > > =C2=A01 file changed, 30 insertions(+), 40 deletions(-)
> > >=20
> > > diff --git
> > > a/tools/testing/selftests/thermal/intel/power_floor/power_floor_t
> > > est.
> > > c
> > > b/tools/testing/selftests/thermal/intel/power_floor/power_floor_t
> > > est.
> > > c
> > > index 0326b39a11b91..c06b275acd36b 100644
> > > ---
> > > a/tools/testing/selftests/thermal/intel/power_floor/power_floor_t
> > > est.
> > > c
> > > +++
> > > b/tools/testing/selftests/thermal/intel/power_floor/power_floor_t
> > > est.
> > > c
> > > @@ -9,6 +9,7 @@
> > > =C2=A0#include <fcntl.h>
> > > =C2=A0#include <poll.h>
> > > =C2=A0#include <signal.h>
> > > +#include "../../../kselftest.h"
> > > =C2=A0
> > > =C2=A0#define POWER_FLOOR_ENABLE_ATTRIBUTE
> > > "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_enabl
> > > e"
> > > =C2=A0#define POWER_FLOOR_STATUS_ATTRIBUTE=C2=A0
> > > "/sys/bus/pci/devices/0000:00:04.0/power_limits/power_floor_statu
> > > s"
> > > @@ -20,17 +21,13 @@ void power_floor_exit(int signum)
> > > =C2=A0	/* Disable feature via sysfs knob */
> > > =C2=A0
> > > =C2=A0	fd =3D open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
> > > -	if (fd < 0) {
> > > -		perror("Unable to open power floor enable
> > > file\n");
> > > -		exit(1);
> > > -	}
> > > +	if (fd < 0)
> > > +		ksft_exit_fail_perror("Unable to open power
> > > floor
> > > enable file");
> > > =C2=A0
> > > -	if (write(fd, "0\n", 2) < 0) {
> > > -		perror("Can' disable power floor
> > > notifications\n");
> > > -		exit(1);
> > > -	}
> > > +	if (write(fd, "0\n", 2) < 0)
> > > +		ksft_exit_fail_perror("Can' disable power floor
> > > notifications");
> > > =C2=A0
> > > -	printf("Disabled power floor notifications\n");
> > > +	ksft_print_msg("Disabled power floor notifications\n");
> > > =C2=A0
> > > =C2=A0	close(fd);
> > > =C2=A0}
> > > @@ -41,6 +38,9 @@ int main(int argc, char **argv)
> > > =C2=A0	char status_str[3];
> > > =C2=A0	int fd, ret;
> > > =C2=A0
> > > +	ksft_print_header();
> > > +	ksft_set_plan(1);
> > > +
> > > =C2=A0	if (signal(SIGINT, power_floor_exit) =3D=3D SIG_IGN)
> > > =C2=A0		signal(SIGINT, SIG_IGN);
> > > =C2=A0	if (signal(SIGHUP, power_floor_exit) =3D=3D SIG_IGN)
> > > @@ -50,59 +50,49 @@ int main(int argc, char **argv)
> > > =C2=A0
> > > =C2=A0	/* Enable feature via sysfs knob */
> > > =C2=A0	fd =3D open(POWER_FLOOR_ENABLE_ATTRIBUTE, O_RDWR);
> > > -	if (fd < 0) {
> > > -		perror("Unable to open power floor enable
> > > file\n");
> > > -		exit(1);
> > > -	}
> > > +	if (fd < 0)
> > > +		ksft_exit_fail_perror("Unable to open power
> > > floor
> > > enable file");
> > > =C2=A0
> > > -	if (write(fd, "1\n", 2) < 0) {
> > > -		perror("Can' enable power floor
> > > notifications\n");
> > > -		exit(1);
> > > -	}
> > > +	if (write(fd, "1\n", 2) < 0)
> > > +		ksft_exit_fail_perror("Can' enable power floor
> > > notifications");
> > > =C2=A0
> > > =C2=A0	close(fd);
> > > =C2=A0
> > > -	printf("Enabled power floor notifications\n");
> > > +	ksft_print_msg("Enabled power floor notifications\n");
> > > =C2=A0
> > > =C2=A0	while (1) {
> > > =C2=A0		fd =3D open(POWER_FLOOR_STATUS_ATTRIBUTE,
> > > O_RDONLY);
> > > -		if (fd < 0) {
> > > -			perror("Unable to power floor status
> > > file\n");
> > > -			exit(1);
> > > -		}
> > > +		if (fd < 0)
> > > +			ksft_exit_fail_perror("Unable to power
> > > floor
> > > status file");
> > > =C2=A0
> > > -		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> > > -			fprintf(stderr, "Failed to set pointer
> > > to
> > > beginning\n");
> > > -			exit(1);
> > > -		}
> > > +		if ((lseek(fd, 0L, SEEK_SET)) < 0)
> > > +			ksft_exit_fail_perror("Failed to set
> > > pointer
> > > to beginning\n");
> > > =C2=A0
> > > -		if (read(fd, status_str, sizeof(status_str)) <
> > > 0) {
> > > -			fprintf(stderr, "Failed to read
> > > from:%s\n",
> > > -			POWER_FLOOR_STATUS_ATTRIBUTE);
> > > -			exit(1);
> > > -		}
> > > +		if (read(fd, status_str, sizeof(status_str)) <
> > > 0)
> > > +			ksft_exit_fail_perror("Failed to read
> > > from:
> > > power_floor_status");
> > > =C2=A0
> > > =C2=A0		ufd.fd =3D fd;
> > > =C2=A0		ufd.events =3D POLLPRI;
> > > =C2=A0
> > > =C2=A0		ret =3D poll(&ufd, 1, -1);
> > > =C2=A0		if (ret < 0) {
> > > -			perror("poll error");
> > > -			exit(1);
> > > +			ksft_exit_fail_msg("Poll error\n");
> > > =C2=A0		} else if (ret =3D=3D 0) {
> > > -			printf("Poll Timeout\n");
> > > +			ksft_print_msg("Poll Timeout\n");
> > > =C2=A0		} else {
> > > -			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> > > -				fprintf(stderr, "Failed to set
> > > pointer to beginning\n");
> > > -				exit(1);
> > > -			}
> > > +			if ((lseek(fd, 0L, SEEK_SET)) < 0)
> > > +				ksft_exit_fail_msg("Failed to
> > > set
> > > pointer to beginning\n");
> > > =C2=A0
> > > =C2=A0			if (read(fd, status_str,
> > > sizeof(status_str))
> > > < 0)
> > > -				exit(0);
> > > +				ksft_exit_fail_perror("Failed to
> > > read");
> > > =C2=A0
> > > -			printf("power floor status: %s\n",
> > > status_str);
> > > +			ksft_print_msg("power floor status:
> > > %s\n",
> > > status_str);
> > > +			break;
> > > =C2=A0		}
> > > =C2=A0
> > > =C2=A0		close(fd);
> > > =C2=A0	}
> > > +
> > > +	ksft_test_result_pass("Successfully read\n");
> > > +	ksft_finished();
> > > =C2=A0}
> >=20
> >=20
>=20


