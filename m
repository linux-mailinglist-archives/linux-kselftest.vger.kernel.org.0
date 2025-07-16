Return-Path: <linux-kselftest+bounces-37420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1907DB0749C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EDB5084DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5A2F3622;
	Wed, 16 Jul 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grOv132y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234352F2C5B;
	Wed, 16 Jul 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665020; cv=none; b=bnAa8l9osp1kSTpPaBOQvGifcZWgABQ9OI86fEexDWhK+nB7MrdLdxaDKD67/Y0jSAYbRqjfr2x10Ia4fZoiTv3R3ZpYKTvOiWypjkBQReH/IFj8l3JRmaGNoyQHvVHPRCOCxuvLHPQE6BXDfzZVoLUvW1j9Qk1veBZ5ART9YOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665020; c=relaxed/simple;
	bh=JwC/4hGvFPQBmgJVtmn3OCu1w02qve0nG2/V6tlCorE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJD6OGi8IwIQfooCxGJQ4+1UPsBTPN+ffu2UwxaBMapozBssV7cXw/B3mWw1Js7qEQWKIPij4JGGrbUtOvmXQJz0Q887mohYGn4yTMnKum8szrmd/1Xe7BcyG90/x3qfOKWQkFcx+wGHJEwgpzIrlwLfh3OGzwDBx5FbS2gHtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grOv132y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350fc2591dso7657765ad.1;
        Wed, 16 Jul 2025 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752665017; x=1753269817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJkYWyPvLjCn2J/SM7UK6829MtGCaON4tomRphmbLQw=;
        b=grOv132y04vvcRmcXw6QjjGWVLbGNbm9cCFIkpuMPRY49rKt76LyWmedQDHfTZjHnm
         grgBjucWMs0Mz9gazbkdOu0EPm4ZrsZVnobQqUOurbUMpMKJMiXqTIq/oEqDGY18v3Uc
         HcQoerowSH25uEVJnprMiRNL2xTcdffxUuM8U+Zbq9zl5aVHJ9o31RUaOw5lo2Tgz7z+
         yIYDLXWF1Iw7AivX0XcHJHQK0lzVlBaANF13+oudo3S3++dOEXzhQb10EPAJMUyW9QDo
         cXr/rber7igHPVh0HcKvrqxPhhGKmE4wWipbLP8q0M7vvlUnSfLcM4cUXHLMNhdoSv4/
         wDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752665017; x=1753269817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJkYWyPvLjCn2J/SM7UK6829MtGCaON4tomRphmbLQw=;
        b=fFD+tnY/UfSb5vfZvsTDDlx/GqR309iqWa4/kKXJRwSbGtcpCbmZGuQPCQj9i+e4d/
         0n4FSl19UbjYu/4piz5Ao1xvhVAE0KtcE0FrqWKzuoJ3uKu4LBuJ6HN8P7EYEGWXVI2o
         OTdeZSkqRQD3Kq44Gv0GfsQ7Y7fAP09UjlT57MV5jO+zEqKhyO51JnTSU1iXxmXXSGIk
         9/dklotcVVpj/Otqu+TsY8XsWawWr3tG/tKN50K1Tnb/oRq7tlYBQzgzP+Fx11LfDzfN
         iPrD21VI+NQiMRU1XsZ2EF7j/nCrIFb8C70DmH10DFHJIGaTaGlcusmK7Y5fMMSYkUiu
         fN2A==
X-Forwarded-Encrypted: i=1; AJvYcCWRevB+0l03dBQewqm2jE41fQb3zA5QG5sTxcnCA7COMz0MjXFF2iEQ+tYx6b04v4OZjbtSPopRhxSVwiEiOiZ6@vger.kernel.org, AJvYcCWlfNRT0/KKf4P8IBLIa6fYEr7D59E7dDAwj/jkOFL8R3cly4CKqbQH6MAADOyLnNeamasgAjnKaabqfyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kRJW52uesbuSF5HM3PwiUauX3Scv8dQ8GZj009tEMzQQcYMF
	gvoujJcJl1KAHxVJf908tCq0avSQ54D2QDcgYo0uCti+bB8BlYrgjopv
X-Gm-Gg: ASbGncsqTqH5kkex49kuWhEFqJ4IDYtS8ayl4D0QQmgUTrcaXNZtl73hqvhGdjlJ5OH
	c7uGzEEzgzHvvLugMPRwFka0lt37PJDlxOuRwB4UrOeJuxp4FKTBAvPa99FsEnfWwicT7n2aCJV
	6g6c9pkbeGAJBi6AesFt3qC4fOXibwgHJTJQ4I92Sw2bWCXc8SiMR78Ksr3EWug5pbOD4woDzQJ
	Jlccn6TT2gEE8tP4RgUOgy+HRD9DpF1gYTMfi/vk82KqGI3VXdlMgyBk9N26qZqCOTY7S19nORf
	Y/l76PcjKjCt5N8ICCG4YbeJF36g3dyeawwbkeP5xPIvZ5dIIyK/D1Mfk5SuqUDmZBa47/hMIdi
	yGBtd7e0jQp9xeaGEieb8BcO7vlGuYSL6c2b8Hg==
X-Google-Smtp-Source: AGHT+IFQlVfWg5grXxTKOXvjVYbxEblgPRnNt7BWpI4bJ24g6U/kAc+R3I6KUTpxqgyu7ycqjlCKqQ==
X-Received: by 2002:a17:902:f78a:b0:235:f091:11e5 with SMTP id d9443c01a7336-23e249b1b20mr38051645ad.10.1752665017153;
        Wed, 16 Jul 2025 04:23:37 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42864a8sm124970345ad.42.2025.07.16.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:23:36 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:23:28 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: bonding: add test for passive LACP
 mode
Message-ID: <aHeLsNbhvqTFge3J@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-3-liuhangbin@gmail.com>
 <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4bbed3-472f-4002-abb9-47edf7743779@redhat.com>

On Tue, Jul 15, 2025 at 11:37:54AM +0200, Paolo Abeni wrote:
> On 7/9/25 11:03 AM, Hangbin Liu wrote:
> > Add a selftest to verify bonding behavior when lacp_active is set to off.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  .../drivers/net/bonding/bond_passive_lacp.sh  | 21 +++++
> >  .../drivers/net/bonding/bond_topo_lacp.sh     | 77 +++++++++++++++++++
> >  2 files changed, 98 insertions(+)
> >  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> >  create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh
> 
> New test should be listed in the relevant makefile

Ah, yes, I forgot this.

> > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> > new file mode 100755
> > index 000000000000..4cf8a5999aaa
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
> > @@ -0,0 +1,21 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Testing if bond works with lacp_active = off
> > +
> > +lib_dir=$(dirname "$0")
> > +source ${lib_dir}/bond_topo_lacp.sh
> 
> shellcheck is not super happy about 'source' usage:
> 
> In bond_passive_lacp.sh line 7:
> source ${lib_dir}/bond_topo_lacp.sh
> ^-- SC3046 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> ^-- SC3051 (warning): In POSIX sh, 'source' in place of '.' is undefined.
> 
> either switch to '. ' or use bash instead of 'sh'.

OK, I will fix this and other warns.

Thanks
Hangbin
> 
> > +lacp_bond_reset "${c_ns}" "lacp_active off"
> > +# make sure the switch state is not expired [A,T,G,S,Ex]
> > +if slowwait 15 ip netns exec ${s_ns} grep -q 'port state: 143' /proc/net/bonding/bond0; then
> 
> Shellcheck wants double quote everywhere. Since in many cases (all the
> blamed ones in this patch) we know the variable is really a single word,
> I think you could simply disable the warning with:
> 
> #shellcheck disable=SC2086
> 
> (same in the other test file)
> 
> > +	RET=1
> > +else
> > +	RET=0
> > +fi
> 
> /P
> 

