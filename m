Return-Path: <linux-kselftest+bounces-44772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A15EC336B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 00:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3E554EE299
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 23:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832634B19F;
	Tue,  4 Nov 2025 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GifgasKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35E34B186;
	Tue,  4 Nov 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300073; cv=none; b=SE9yHuXH0s06MjgoBpDNhwXWO9k6Y1i9UyGw0rPp0lyIZyL4Ya8G2Y1S/E5Q23Ngl7bauTXNRSGt48UsJ7jjgzuVtntejNlWxav1wk2wNFmtbYHPFTnOiqHWkpDPfdv70BSru93af7hFg91P3UNOg/CtW35qPDNakjy1OnEUIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300073; c=relaxed/simple;
	bh=fEsn3jOrCN93c6qUqNl2qj5zUfUGbA4A30+4VyWcL6o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=efrz6WCdt7jm5495H3m3TsARF0PKsah0TEZ4xytsODC6zp3wDJa+X3mO3DGd9jNTHO+Wd54s0mCwyQQLeODhQ1Uw4wy36aik7jBlye9O6VemWMWp0xbSmZvjI4OoTcrFatMRAWntqfYspsOYY4sjK+7ax7VqdF5ooHhjAPThZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GifgasKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E2FC4CEF7;
	Tue,  4 Nov 2025 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762300072;
	bh=fEsn3jOrCN93c6qUqNl2qj5zUfUGbA4A30+4VyWcL6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GifgasKwjeePbhflYlgd4hJiKOTL0PN8UFtOLFGNE50PA7Md4557Iix92WelIc1Jd
	 B/+JIEV4c+OiRNjG35DM22q0ZKcwRokM6vBxdNth1Tg62rGSMSuBz/IgVHssX2RmPo
	 WpZk/VmI4dYdYjihKj8ExggTH1olkoqD8WC127noU3KnSicUXgZDwr5BQFGe+oOS4l
	 dn1qL+ZuszUWMtnEyEWr8VvTlouP4mVmhYmqBUitVqNmNGfei6O9MFRfsAh0UkS4uc
	 p23ZfDJa8L32R8s6OAIwS6FqPcjgLXsJc/FHQWNeotIC3s9/5XN+BnGOkbgNPfDDiS
	 zHuf30b9LyG9Q==
Date: Wed, 5 Nov 2025 08:47:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] selftests/tracing: Add basic test for trace_marker_raw
 file
Message-Id: <20251105084748.f34e1efec291d420a50a7b62@kernel.org>
In-Reply-To: <20251014145149.3e3c1033@gandalf.local.home>
References: <20251014145149.3e3c1033@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 14:51:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Commit 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read
> user space") made an update that fixed both trace_marker and
> trace_marker_raw. But the small difference made to trace_marker_raw had a
> blatant bug in it that any basic testing would have uncovered.
> Unfortunately, the self tests have tests for trace_marker but nothing for
> trace_marker_raw which allowed the bug to get upstream.
> 
> Add basic selftests to test trace_marker_raw so that this doesn't happen
> again.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/00basic/trace_marker_raw.tc | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> new file mode 100644
> index 000000000000..7daf7292209e
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> @@ -0,0 +1,107 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Basic tests on writing to trace_marker_raw
> +# requires: trace_marker_raw
> +# flags: instance
> +
> +is_little_endian() {
> +	if lscpu | grep -q 'Little Endian'; then
> +		echo 1;
> +	else
> +		echo 0;
> +	fi
> +}
> +
> +little=`is_little_endian`
> +
> +make_str() {
> +	id=$1
> +	cnt=$2
> +
> +	if [ $little -eq 1 ]; then
> +		val=`printf "\\%03o\\%03o\\%03o\\%03o" \
> +			$(($id & 0xff)) \
> +			$((($id >> 8) & 0xff)) \
> +			$((($id >> 16) & 0xff)) \
> +			$((($id >> 24) & 0xff))`
> +	else
> +		val=`printf "\\%03o\\%03o\\%03o\\%03o" \
> +			$((($id >> 24) & 0xff)) \
> +			$((($id >> 16) & 0xff)) \
> +			$((($id >> 8) & 0xff)) \
> +			$(($id & 0xff))`
> +	fi
> +
> +	data=`printf -- 'X%.0s' $(seq $cnt)`
> +
> +	printf "${val}${data}"
> +}
> +
> +write_buffer() {
> +	id=$1
> +	size=$2
> +
> +	# write the string into the raw marker
> +	make_str $id $size > trace_marker_raw
> +}
> +
> +
> +test_multiple_writes() {
> +
> +	# Write a bunch of data where the id is the count of
> +	# data to write
> +	for i in `seq 1 10` `seq 101 110` `seq 1001 1010`; do
> +		write_buffer $i $i
> +	done
> +
> +	# add a little buffer
> +	echo stop > trace_marker
> +
> +	# Check to make sure the number of entries is the id (rounded up by 4)
> +	awk '/.*: # [0-9a-f]* / {
> +			print;
> +			cnt = -1;
> +			for (i = 0; i < NF; i++) {
> +				# The counter is after the "#" marker
> +				if ( $i == "#" ) {
> +					i++;
> +					cnt = strtonum("0x" $i);
> +					num = NF - (i + 1);
> +					# The number of items is always rounded up by 4
> +					cnt2 = int((cnt + 3) / 4) * 4;
> +					if (cnt2 != num) {
> +						exit 1;
> +					}
> +					break;
> +				}
> +			}
> +		}
> +	// { if (NR > 30) { exit 0; } } ' trace_pipe;
> +}
> +
> +
> +get_buffer_data_size() {
> +	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
> +}
> +
> +test_buffer() {
> +
> +	# The id must be four bytes, test that 3 bytes fails a write
> +	if echo -n abc > ./trace_marker_raw ; then
> +		echo "Too small of write expected to fail but did not"
> +		exit_fail
> +	fi
> +
> +	size=`get_buffer_data_size`
> +	echo size = $size
> +
> +	# Now add a little more than what it can handle
> +
> +	if write_buffer 0xdeadbeef $size ; then
> +		echo "Too big of write expected to fail but did not"
> +		exit_fail
> +	fi
> +}
> +
> +test_buffer
> +test_multiple_writes
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

