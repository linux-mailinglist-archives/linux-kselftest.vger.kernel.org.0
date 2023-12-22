Return-Path: <linux-kselftest+bounces-2402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382281CD37
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97874B2120D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F224B49;
	Fri, 22 Dec 2023 16:39:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118324B3D;
	Fri, 22 Dec 2023 16:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63E7C433C8;
	Fri, 22 Dec 2023 16:39:44 +0000 (UTC)
Date: Fri, 22 Dec 2023 11:40:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux selftests
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3] tracing/selftests: Add ownership modification tests
 for eventfs
Message-ID: <20231222114050.17471305@gandalf.local.home>
In-Reply-To: <20231222112831.4c7fa500@gandalf.local.home>
References: <20231221211229.13398ef3@gandalf.local.home>
	<20231221211604.5062f4e8@gandalf.local.home>
	<935441c3-f14b-4a5d-8031-3b406548a612@linuxfoundation.org>
	<20231222112831.4c7fa500@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2023 11:28:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:


> > -- this file has executable permission set unlike the existing
> >     .tc files in the same directory =20
>=20
> Oh, I forgot to disable that. When developing a new test I make it
> standalone as it's easier to test the test, and then copy the file into t=
he
> directory.
>=20

I noticed that I did the same for trace_marker.tc that's in my for-next
queue. Instead of rebasing, as there's other commits on top of it, I'm just
going to push this to my for-next queue.

-- Steve

=46rom 26547691107eda45b0f20ee79bad19bbe5fcbfd7 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Fri, 22 Dec 2023 11:35:22 -0500
Subject: [PATCH] tracing/selftests: Remove exec permissions from
 trace_marker.tc test

The tests in the selftests should not have the exec permissions set. The
trace_marker.tc test accidentally was committed with the exec permission.

Set the permission to that file back to just read/write.

No functional nor code changes.

Link: https://lore.kernel.org/linux-trace-kernel/20231222112831.4c7fa500@ga=
ndalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 =3D> 100644 tools/testing/selftests/ftrace/test.d/00bas=
ic/trace_marker.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc =
b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
old mode 100755
new mode 100644
--=20
2.42.0


