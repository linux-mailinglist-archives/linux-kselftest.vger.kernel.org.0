Return-Path: <linux-kselftest+bounces-47969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28996CDEE1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 19:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DF153000B5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFC2147E5;
	Fri, 26 Dec 2025 18:29:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDF4C6D;
	Fri, 26 Dec 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766773775; cv=none; b=cJiKhYiLH8rvjZ1BH379YXPchp/qWZ4kCM0VKaNa7BZkTuUTl1sMaRudqmTUXWrysxryAZJHo8E+HA4z23GiOvYrZNwBCe4m7MlPe/0OSAjWzzwfTNPM+2mMSwDjh2y5u92WrNefZDhB6g3q3dRompcWurez0sw9R8KcDojt+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766773775; c=relaxed/simple;
	bh=wXvJ5JSc0GFM5PQ4+3tYEdDRSxCQ7HpHqwhvc0/li90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyJgMW62l51oOJ4ytXwF3UctHizGWkY3e2qhcZZunPIRRtBgDimhliXNNf0UvusEupIk20ozoN3tHvC5icdxyN1n6cWmt4k/pa0KJhb9c3axdo/E2gIdblcNgg7ynfk5p/haouub4tO4B5Snwj3Shb7TUquLRQ59mAMvlmdKjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 9063485E01;
	Fri, 26 Dec 2025 18:29:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 820F42001F;
	Fri, 26 Dec 2025 18:29:28 +0000 (UTC)
Date: Fri, 26 Dec 2025 13:29:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 wangfushuai@baidu.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/tracing: Fix test_multiple_writes stall
Message-ID: <20251226132927.4c406bd9@gandalf.local.home>
In-Reply-To: <20251226091217.58992-1-fushuai.wang@linux.dev>
References: <20251226091217.58992-1-fushuai.wang@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: acyg6tpba7whfkqkjgntw6iixw38od5s
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 820F42001F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/jVxtCXlVTVaCNAIbIu6Hwa+yZYqZ1XXQ=
X-HE-Tag: 1766773768-981535
X-HE-Meta: U2FsdGVkX1+A+18vnYsoCTdJYhr0myPHS4QUg/rwUb66kN9c+qgcq5+d7flHp83aTQAHWZXwXrTxOSB48YVSXgYhDLgSHQ4/atpD4IoSc4yQOtXafgZRraE/nPKGoUeybH0tePzlSXd/vgtRjT1gDU8mr/ZA6amDqaxPs3MxnSk6gqf8t1VDMxxZiNwMYUcj30nq2ksXJvrkqD0B+W6kiFjAhFaPHPgpQWpr+A7xrlVguZQ6vV+dALWvWaOiUEKBfyWugB1tHvNoTjbJ0p3mQExFAkvYcrXZ3xrpwjGj1COHmGiEVnuZK/a30+tSwgm/IffLnEOKuBCrquP8GP0sv8jzXqA3WLgvSldGe8vZnjVbhpcbwASgTVyDdMXgCKz4i5FcMnfXTfk=

On Fri, 26 Dec 2025 17:12:17 +0800
Fushuai Wang <fushuai.wang@linux.dev> wrote:

> When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
> the test_multiple_writes test will stall and wait for more
> input due to insufficient buffer space.
>=20
> This patch check current buffer_size_kb value before the test.

Never use "This patch" in a change log. See Submitting Patches:

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

    Describe your changes in imperative mood, e.g. =E2=80=9Cmake xyzzy do f=
rotz=E2=80=9D
    instead of =E2=80=9C[This patch] makes xyzzy do frotz=E2=80=9D or =E2=
=80=9C[I] changed xyzzy to
    do frotz=E2=80=9D, as if you are giving orders to the codebase to chang=
e its
    behaviour.


> If it is less than 12KB, it temporarily increase the buffer to
> 12KB, and restore the original value after the tests are completed.
>=20
> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_=
raw file")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  .../ftrace/test.d/00basic/trace_marker_raw.tc    | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_r=
aw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> index 7daf7292209e..216f87d89c3f 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> @@ -58,7 +58,7 @@ test_multiple_writes() {
>  	echo stop > trace_marker
> =20
>  	# Check to make sure the number of entries is the id (rounded up by 4)
> -	awk '/.*: # [0-9a-f]* / {
> +	awk -v ORIG=3D"${ORIG}" '/.*: # [0-9a-f]* / {
>  			print;
>  			cnt =3D -1;
>  			for (i =3D 0; i < NF; i++) {
> @@ -70,6 +70,7 @@ test_multiple_writes() {
>  					# The number of items is always rounded up by 4
>  					cnt2 =3D int((cnt + 3) / 4) * 4;
>  					if (cnt2 !=3D num) {
> +						system("echo \""ORIG"\" > buffer_size_kb");

Why are you doing this in the awk script?

>  						exit 1;
>  					}
>  					break;
> @@ -89,6 +90,7 @@ test_buffer() {
>  	# The id must be four bytes, test that 3 bytes fails a write
>  	if echo -n abc > ./trace_marker_raw ; then
>  		echo "Too small of write expected to fail but did not"
> +		echo $ORIG > buffer_size_kb
>  		exit_fail
>  	fi
> =20
> @@ -99,9 +101,21 @@ test_buffer() {
> =20
>  	if write_buffer 0xdeadbeef $size ; then
>  		echo "Too big of write expected to fail but did not"
> +		echo $ORIG > buffer_size_kb
>  		exit_fail
>  	fi
>  }
> =20
> +ORIG=3D`cat buffer_size_kb`
> +
> +# test_multiple_writes test needs at least 12KB buffer
> +NEW_SIZE=3D12
> +
> +if [ ${ORIG} -lt ${NEW_SIZE} ]; then
> +	echo ${NEW_SIZE} > buffer_size_kb
> +fi
> +
>  test_buffer
>  test_multiple_writes

Could add:

  if ! test_multiple_writes ; then
	echo $ORIG > buffer_size_kb
	exit_fail
  fi

instead.

-- Steve

> +
> +echo $ORIG > buffer_size_kb


