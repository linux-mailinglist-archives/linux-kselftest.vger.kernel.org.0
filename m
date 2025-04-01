Return-Path: <linux-kselftest+bounces-29969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7646A77265
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 03:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DD1188D8B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 01:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C609935949;
	Tue,  1 Apr 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lcQE7fay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC91CA84
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471869; cv=none; b=e0z2rVlPWiIEdtoyaOi83v431bC4jCtrviW8jcKw2Riu6hgIM8qjsxWbMoFWb20FDpjgV3BDKrenC7V01BNEkCph+TDp1oAtjksPfMCxeCaPtzrXzGFVsMAP2yLHiLCy35pcRJICDTgrxeeB9yo0afytYa0x4J1saljj4dEeXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471869; c=relaxed/simple;
	bh=86O2hfdb+M6JkiIHraoC26A0ZCa1JQ71BJmAr2m3030=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8GoYQ7c2JTO+vS0hyIsrrvxBRISxyz/oaxDh8ZOVcNLN9mQwGxshxRu0hsTOaELyUATPsaJiVEVT78+QIeCd2E3bOcgP10Q7aT6eRBKQCFl8uyEEbODdNwLWoH8MkZHwdYyQ8Bv+ip/5VnQrFrqwEmMTDioJJy+478N50ROffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lcQE7fay; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1743471841;
	bh=xsajgwmzhojNa/SRRqY1q1TvBenBJgKGiWh1dXGqqvk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=lcQE7fayTNK7L8GtSVZR3tuc5wU7z1Z6pKq45wVjx1+3p9q0MfkOOlbUHKW8TyaG5
	 W6YI4YFqxI93Hb/ye04u7jzHgO+OLhD0zajjTFkg2+Eyqh9+4hOuw3RjYSxYvL/AjE
	 l4RURD307UMKH5b6lwnALsEiYETWvOpM/nKELRDM=
X-QQ-mid: bizesmtp79t1743471834toqj6j4l
X-QQ-Originating-IP: FFsAJBJXsVhcl7D7lv8G5pvpXO8tGpqS22eruJX7qSY=
Received: from rocky ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Apr 2025 09:43:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12323414449211283021
Date: Tue, 1 Apr 2025 09:43:52 +0800
From: Lu Fei <lufei@uniontech.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-kselftest <linux-kselftest@vger.kernel.org>,
	viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] unshare_test: set nr_open using soft limit
Message-ID: <350753235A42C70B+Z+tE2GNpRZRMAUOi@rocky>
References: <20250328144717.108054-1-lufei@uniontech.com>
 <20250331183227.GA279891@pevik>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331183227.GA279891@pevik>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MXqQCeYgv6iWovB+pGhyX+3U8fn/pPnyosDY72ly2MNMT4jrJnLFdO2r
	SPmaDV5l13wt9RDUm6BE0BlqA1vScCOjx8TAO2TmHGQv5EacUETJXLGeafBF+ETyNkVOu8B
	74B5spM9aY65owh3jyXXt8PYKiEdTmaWbncfeuwNKTQInCM33YyKkevp0hSM1wSiqLLxA4F
	B5viePMA8XImCGVGT8ROaRPl7GT2NPXHcpFOcBWZUS5Nb8OVhS7BKIxfXvfAoAj076yescs
	gZ1uAgNMANA9zqs5eL1JoO9Zjq991u0N+eA5DwEbRQOB5uPBrv4m7kkvbH2rbO6QfyR28OE
	ryQbLZoLcwPBbCGjrva44jvbUoP84hqMPI8SYZC13kTYcPukgVc1CzHGIAyOLasuASvbauZ
	QmSIYdU3LZi0YRUitDaqw7vm5l5lWbYQt1BLz2kJ1VRO6MCFq1kXN/egSgsyhzAQ0PTlINb
	xPQTJpLPmIIOCkXOWVArz2IVtAe1zD7SaXRSgDEbLitKGbqqMitY/qu6N8O0kWOSb7zimM+
	/w6MaJwcG94vG0v1Pd6595gGO/2n6sULmEJHYsbnEVQkmtlBGsPgZXlKoOofymX9DK57WZn
	oYmxVQiraPCuCsJvQP7oB2gkYkeIpdYgEzQHZCyuPXPZkpMFex1+6t+Dnb8QIcIiMMPdM8y
	p8dkf/WishYcCBmaYi63ps4Rp/5R5V5hiMYp/91H8eTuAgl69b+pXbAJGDaHqhESTFl1WS+
	dcRKnLIGpa8qraOt7m3DxQrelQdI0GTlFOJqk8XzaBE0DNZn6AQyvP+DR4q8DVo3aNBmjOX
	Fkd8j/xnMNeVTkkWDZSwJjMu1fMmg2cGnB5hyutXkxAgfdUpVAlEnLfO6i5MDS0J5u0WrnP
	1wLngHpdUvaDtDI8K0Qa6OwE++AK1MngBbhzYTtH5dYwT191WlGX1BU+GTRTDrb8xWI5vIO
	mrxtcO8M1MIfg+zK+lHIgK9h1Ob4A6C8NUOU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Hi Petr,

Thanks very much for reply.

On Mon, Mar 31, 2025 at 08:32:27PM +0200, Petr Vorel wrote:
> Hi all,
> 
> > Set maximum file descriptor number limit by rlimit.rlim_max than
> > nr_open(hard limit). Hard limit may cause dup2 fail.
> 
> It actually changes from failure:
> 
> # ./unshare_test 
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           global.unshare_EMFILE ...
> # unshare_test.c:60:unshare_EMFILE:Expected dup2(2, nr_open + 64) (-1) >= 0 (0)
> # unshare_EMFILE: Test failed
> #          FAIL  global.unshare_EMFILE
> not ok 1 global.unshare_EMFILE
> # FAILED: 0 / 1 tests passed.
> # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> to pass:
> 
> TAP version 13
> 1..1
> # Starting 1 tests from 1 test cases.
> #  RUN           global.unshare_EMFILE ...
> #            OK  global.unshare_EMFILE
> ok 1 global.unshare_EMFILE
> # PASSED: 1 / 1 tests passed.
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> > Signed-off-by: lufei <lufei@uniontech.com>
> > ---
> >  tools/testing/selftests/core/unshare_test.c | 28 +++++++++++++--------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> > diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
> > index 7fec9dfb1b0e..2c4e7104b0d9 100644
> > --- a/tools/testing/selftests/core/unshare_test.c
> > +++ b/tools/testing/selftests/core/unshare_test.c
> > @@ -26,10 +26,11 @@ TEST(unshare_EMFILE)
> >  		.exit_signal = SIGCHLD,
> >  	};
> >  	int fd;
> > -	ssize_t n, n2;
> > -	static char buf[512], buf2[512];
> > +	ssize_t n, n2, n3;
> > +	static char buf[512], buf2[512], buf3[512];
> >  	struct rlimit rlimit;
> >  	int nr_open;
> > +	int rlimit_max;
> 
> >  	fd = open("/proc/sys/fs/nr_open", O_RDWR);
> >  	ASSERT_GE(fd, 0);
> > @@ -42,22 +43,24 @@ TEST(unshare_EMFILE)
> 
> >  	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
> 
> > -	/* bump fs.nr_open */
> > -	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
> > +	rlimit_max = rlimit.rlim_max;
> > +
> > +	/* bump rlimit.rlim_max */
> > +	n2 = sprintf(buf2, "%d\n", rlimit_max + 1024);
> >  	lseek(fd, 0, SEEK_SET);
> >  	write(fd, buf2, n2);
> 
> >  	/* bump ulimit -n */
> > -	rlimit.rlim_cur = nr_open + 1024;
> > -	rlimit.rlim_max = nr_open + 1024;
> > +	rlimit.rlim_cur = rlimit_max + 1024;
> > +	rlimit.rlim_max = rlimit_max + 1024;
> >  	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
> >  		lseek(fd, 0, SEEK_SET);
> >  		write(fd, buf, n);
> >  		exit(EXIT_FAILURE);
> >  	}
> 
> > -	/* get a descriptor past the old fs.nr_open */
> > -	EXPECT_GE(dup2(2, nr_open + 64), 0) {
> > +	/* get a descriptor past the old rlimit.rlim_max */
> > +	EXPECT_GE(dup2(2, rlimit_max + 64), 0) {
> >  		lseek(fd, 0, SEEK_SET);
> >  		write(fd, buf, n);
> >  		exit(EXIT_FAILURE);
> > @@ -74,15 +77,20 @@ TEST(unshare_EMFILE)
> >  	if (pid == 0) {
> >  		int err;
> 
> > -		/* restore fs.nr_open */
> > +		n3 = sprintf(buf3, "%d\n", rlimit_max);
> >  		lseek(fd, 0, SEEK_SET);
> > -		write(fd, buf, n);
> > +		write(fd, buf3, n3);
> nit: do we really need buf3? Can't we reuse buf2?
> Or do I miss something obvious?
> 
Reuse buf2 is better. I'll make change.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> > +
> >  		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
> >  		err = unshare(CLONE_FILES);
> >  		EXPECT_EQ(err, -1)
> >  			exit(EXIT_FAILURE);
> >  		EXPECT_EQ(errno, EMFILE)
> >  			exit(EXIT_FAILURE);
> > +
> > +		/* restore fs.nr_open */
> > +		lseek(fd, 0, SEEK_SET);
> > +		write(fd, buf, n);
> >  		exit(EXIT_SUCCESS);
> >  	}
> 

