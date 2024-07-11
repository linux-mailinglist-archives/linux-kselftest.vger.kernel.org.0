Return-Path: <linux-kselftest+bounces-13590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573292EB85
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 17:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B331C22D18
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6B16C6BD;
	Thu, 11 Jul 2024 15:18:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1AAD39;
	Thu, 11 Jul 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711116; cv=none; b=b7cXxq5Zya8j9wDD1tncRpelPlk0sjQZ85w0aIJdaEZNlxGH6AHliEzRbIlZMPei1LQcpcoe5DGI32c1fA/288DiyH4mvTxfPYrk2Dq/03kyRe3xQ61rshwIHtAeITUMMGcc/AOn0Tpb5wenIjl7ox6UQAuavZjuYmoITFrLFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711116; c=relaxed/simple;
	bh=Tq1oeU1YPdBdfADF26/cofRUjx0OrnlvxD8M3h1GQwk=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=WJBJtWYa5mUKnnp+03LMTQoigWG5RcEiuJfTJY9aSMm+ckyA/F9BtAtGMa6DWaQUn0AqvaT9fwUYn2IU+120r8e3pG9alx1fgGsEU+J9lDJsQVEAaJPdZjjKqn+P+HExP83p8a//lK98+rhSHKoTnEHiC3AeFH6KUycLPOoDk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 29DAF3782207;
	Thu, 11 Jul 2024 15:18:32 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <CAJZ5v0gYj5MfwVZihiJEFUWohRmKjudOEExpYgew0Fg4Cu+whA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240711121033.3569948-1-shreeya.patel@collabora.com> <CAJZ5v0gYj5MfwVZihiJEFUWohRmKjudOEExpYgew0Fg4Cu+whA@mail.gmail.com>
Date: Thu, 11 Jul 2024 16:18:31 +0100
Cc: viresh.kumar@linaro.org, shuah@kernel.org, linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
To: =?utf-8?q?Rafael_J=2E_Wysocki?= <rafael@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2e667d-668ff800-1-22d70300@133606496>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?kselftest=3A?==?utf-8?q?_cpufreq=3A?= 
 Add RTC wakeup alarm
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Thursday, July 11, 2024 17:43 IST, "Rafael J. Wysocki" <rafael@kerne=
l.org> wrote:

Hi,

> On Thu, Jul 11, 2024 at 2:10=E2=80=AFPM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
> >
> > Add RTC wakeup alarm for devices to resume after specific time inte=
rval.
> > This improvement in the test will help in enabling this test
> > in the CI systems and will eliminate the need of manual interventio=
n
> > for resuming back the devices after suspend/hibernation.
>=20
> Why don't you use rtcwake for this?
>=20

You are right, using rtcwake would have been better here.
I'll send a v2 with the changes


Thanks,
Shreeya Patel

> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > ---
> >  tools/testing/selftests/cpufreq/cpufreq.sh | 24 ++++++++++++++++++=
++++
> >  tools/testing/selftests/cpufreq/main.sh    | 13 +++++++++++-
> >  2 files changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/tes=
ting/selftests/cpufreq/cpufreq.sh
> > index a8b1dbc0a3a5..a0f5b944a8fe 100755
> > --- a/tools/testing/selftests/cpufreq/cpufreq.sh
> > +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
> > @@ -231,6 +231,30 @@ do=5Fsuspend()
> >
> >                 for i in `seq 1 $2`; do
> >                         printf "Starting $1\n"
> > +
> > +                       if [ "$3" =3D "rtc" ]; then
> > +                               now=3D$(date +%s)
> > +                               wakeup=5Ftime=3D$((now + 15)) # Wak=
e up after 15 seconds
> > +
> > +                               echo $wakeup=5Ftime > /sys/class/rt=
c/rtc0/wakealarm
> > +
> > +                               if [ $? -ne 0 ]; then
> > +                                       printf "Failed to set RTC w=
ake alarm\n"
> > +                                       return 1
> > +                               fi
> > +
> > +                               # Enable the RTC as a wakeup source
> > +                               echo enabled > /sys/class/rtc/rtc0/=
device/power/wakeup
> > +
> > +                               if [ $? -ne 0 ]; then
> > +                                       printf "Failed to set RTC w=
ake alarm\n"
> > +                                       return 1
> > +                               fi
> > +
> > +                               # Reset the wakeup alarm
> > +                               echo 0 > /sys/class/rtc/rtc0/wakeal=
arm
> > +                       fi
> > +
> >                         echo $filename > $SYSFS/power/state
> >                         printf "Came out of $1\n"
> >
> > diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testin=
g/selftests/cpufreq/main.sh
> > index a0eb84cf7167..f12ff7416e41 100755
> > --- a/tools/testing/selftests/cpufreq/main.sh
> > +++ b/tools/testing/selftests/cpufreq/main.sh
> > @@ -24,6 +24,8 @@ helpme()
> >         [-t <basic: Basic cpufreq testing
> >              suspend: suspend/resume,
> >              hibernate: hibernate/resume,
> > +            suspend=5Frtc: suspend/resume back using the RTC wakeu=
p alarm,
> > +            hibernate=5Frtc: hibernate/resume back using the RTC w=
akeup alarm,
> >              modtest: test driver or governor modules. Only to be u=
sed with -d or -g options,
> >              sptest1: Simple governor switch to produce lockdep.
> >              sptest2: Concurrent governor switch to produce lockdep=
.
> > @@ -76,7 +78,8 @@ parse=5Farguments()
> >                                 helpme
> >                                 ;;
> >
> > -                       t) # --func=5Ftype (Function to perform: ba=
sic, suspend, hibernate, modtest, sptest1/2/3/4 (default: basic))
> > +                       t) # --func=5Ftype (Function to perform: ba=
sic, suspend, hibernate,
> > +                          # suspend=5Frtc, hibernate=5Frtc, modtes=
t, sptest1/2/3/4 (default: basic))
> >                                 FUNC=3D$OPTARG
> >                                 ;;
> >
> > @@ -121,6 +124,14 @@ do=5Ftest()
> >                 do=5Fsuspend "hibernate" 1
> >                 ;;
> >
> > +               "suspend=5Frtc")
> > +                do=5Fsuspend "suspend" 1 rtc
> > +                ;;
> > +
> > +                "hibernate=5Frtc")
> > +                do=5Fsuspend "hibernate" 1 rtc
> > +                ;;
> > +
> >                 "modtest")
> >                 # Do we have modules in place?
> >                 if [ -z $DRIVER=5FMOD ] && [ -z $GOVERNOR=5FMOD ]; =
then
> > --
> > 2.39.2
> >
> >
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com


