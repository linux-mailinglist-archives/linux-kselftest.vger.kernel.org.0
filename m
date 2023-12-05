Return-Path: <linux-kselftest+bounces-1201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475B3805E2A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A040B20F4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2167E77;
	Tue,  5 Dec 2023 18:55:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E2C0;
	Tue,  5 Dec 2023 10:55:45 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1884D120237;
	Tue,  5 Dec 2023 18:55:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id DFE226000C;
	Tue,  5 Dec 2023 18:55:38 +0000 (UTC)
Message-ID: <9fe310a9d4486ecf57669bf7b44a49c1788452c1.camel@perches.com>
Subject: Re: [RFC PATCH v2 01/10] get_maintainer: Survive querying missing
 files
From: Joe Perches <joe@perches.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, 
	workflows@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft
	 <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>, David Gow
	 <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, Mark Brown
	 <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Darrick J .
	Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, Veronika
 Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
Date: Tue, 05 Dec 2023 10:55:37 -0800
In-Reply-To: <20231205184503.79769-2-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
	 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
	 <20231205184503.79769-2-Nikolai.Kondrashov@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DFE226000C
X-Rspamd-Server: rspamout06
X-Stat-Signature: gj851n1tw478d59kry4f4sgzaoyu3ejq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+pAWtFOOiT1czbuUFmAevEF0hBsfbYuVg=
X-HE-Tag: 1701802538-803811
X-HE-Meta: U2FsdGVkX1+HD2pYenfxZjLJYvw3eCy+sNXc7z0F5XHJk3yx0Vo/Kcs3/NVi8U3EgOrsYCPpt1tA1fkkq2BQPcAeSTtJ0rjaJQkrQiXZK4nwIaHLzsys2/3LLUhn/6Qq3Wc5xdIGZfxMLcjxR/36JCAZNhEhPkrnD6X11DNwUFGO3cFo6q/V0pLg7h18cd+KAY29IIXE3lSKOzkDcOXfAPXQavHHqKe3NoQSlfDt7L2fH3HI+qlMpAi7Ys8mL05jpsKRVrGDeOOO8Mkw15aR2PJMNLyjaFV9pDdC8+bCUz9aLN0qbkkmCbseY1/vcD5DSEAjUB3NrBTIMGTiZA+ws1M02cCIIPBygijlm5HorKE=

On Tue, 2023-12-05 at 20:02 +0200, Nikolai Kondrashov wrote:
> Do not die, but only warn when scripts/get_maintainer.pl is asked to
> retrieve information about a missing file.
>=20
> This allows scripts/checkpatch.pl to query MAINTAINERS while processing
> patches which are removing files.

Why is this useful?

Give a for-instance example please.

