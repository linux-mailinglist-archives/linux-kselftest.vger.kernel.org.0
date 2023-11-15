Return-Path: <linux-kselftest+bounces-173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA907ECAA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 19:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2201C20978
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86731753;
	Wed, 15 Nov 2023 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 10:40:57 PST
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2979B
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 10:40:57 -0800 (PST)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id F331A40850;
	Wed, 15 Nov 2023 18:31:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id EC19B20028;
	Wed, 15 Nov 2023 18:31:22 +0000 (UTC)
Message-ID: <2e8979163c8ed93f6990c6a91c34cdf96a76daaf.camel@perches.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
From: Joe Perches <joe@perches.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, 
 workflows@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Theodore
 Ts'o <tytso@mit.edu>, David Gow <davidgow@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, "Darrick J . Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, Veronika
 Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
Date: Wed, 15 Nov 2023 10:31:21 -0800
In-Reply-To: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
	 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: EC19B20028
X-Stat-Signature: udaagxznsk9asmhndu3d835jjrbk6cxz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+4jip3LSD+Jej7pjexnseIWLQolUhj808=
X-HE-Tag: 1700073082-6522
X-HE-Meta: U2FsdGVkX1/xDCxqJSd44iIIaFO5Qzsc9gVNZDyfawy1q1z1bDfzscTNzfIdVz+ziykMKsGmpfilS/0145bWJURD6yJK6LefA8ONPfsyY5hLv/LjU+QNmF7zU6Z0xPY7QpDCNQNArMhNhlRWf2mh5zc4+awzDW3EtvMaJQ35O5Wv7VdvSEH7+ug/wsz18bzR4dM0rYb+IdcatpeJOFDVGOMvfduhd3IhGqxBaPqNWx3nVMiSoCUrCLm8hMltlTGQZbIPZi4dlKPSRX1j1y9632k7NIkT7t5c9Md+PW5qzdOpePA0lhHXMvhuvaQh5UmmQNWWT24x2dJQEsn7eYFhxlMuRpTXg9yu

On Wed, 2023-11-15 at 19:43 +0200, Nikolai Kondrashov wrote:
> Introduce a new 'V:' ("Verify") field to MAINTAINERS. The field accepts
> a name of a test suite which is required to be executed for each
> contribution to the subsystem.

Perhaps this is simply too much overhead
process requirements for most kernel work.

While the addition of V: seems ok, I think
putting the verification in checkpatch is
odd at best and the verification of test
execution should be a separate script.



