Return-Path: <linux-kselftest+bounces-11920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A1908755
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF805B220A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5F1922E1;
	Fri, 14 Jun 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiW/ysVs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F9191497;
	Fri, 14 Jun 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357130; cv=none; b=L+0VKz4QJEpjyiQ6UgFXA+K6c+wq/P86PYiStTdqRr4QX3gC3ZkBF2EzaTv7d4u0hysMKHk83MhH7PtTaSVGQzWOb0GsCLHuoXHoE2hXEQFZq/Q9jBDeVfT9N0LuhDv7cinZVIKMPa1LTqcJYgfQAkVisFwaHGB5n7f+B35ASVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357130; c=relaxed/simple;
	bh=ahmJ4DUtC/KtQwSFizke71LMBIHWUNU2u1aqPfaaGOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2hXpNcJi+jT5IODBqbSj08joFFAkTk3qXDKqFdC4DiuJq/WPiqeKVHmtcQOOEZ9b/PIqyjDvNcu7aChaI2PpYGtO/wPGWFMUfU8zp1cjWw+4n0jGsxpsLxzdIHQimjwYXyt81hoHLWytXIDDcpFjtMcYZ0FNkSg06XOgE5Bmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiW/ysVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD51C2BD10;
	Fri, 14 Jun 2024 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718357130;
	bh=ahmJ4DUtC/KtQwSFizke71LMBIHWUNU2u1aqPfaaGOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiW/ysVs2zmxbYPWOVfdrHnRbJbMLsZe59HM6uL3X+csssJ0WoJccpNbEECekwzGp
	 17rmMjNSXHR2QosV38XvjUVo6QY0ryRfi+gWAN/aUbBJgTKqDGHQkXBQ6iIk8/mQCp
	 ZxUaDAZrN9TKArfRHvfuvbpM47dB4957kPPkKg1r5vy79U1oWwN/zh8DV7lmDCGiDT
	 ircOzhlpVUe5NVJldmgdsooHiPW2bkFMhshXijdIHZB0ldzhOLJW2X/eGvuf2xKK5i
	 bJ71F+1NaJcHp8r8kJmiSXrpM4EVlJy5aXwkj9TYthsBqD9vcT2CM054Myjpm16h52
	 uDVy9MKniQVpw==
Date: Fri, 14 Jun 2024 11:25:25 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH HID v3 03/16] HID: bpf: implement HID-BPF through
 bpf_struct_ops
Message-ID: <toq56n25r3jkxbnea6g5wxj3oc4zpgqbor5qjzg444uyh3bx3a@zh4sepdjrwob>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
 <20240608-hid_bpf_struct_ops-v3-3-6ac6ade58329@kernel.org>
 <CAADnVQJDZju=QMiAH=TpYHr6KQh3-TT-jNtJ-O2u7JstY5486Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJDZju=QMiAH=TpYHr6KQh3-TT-jNtJ-O2u7JstY5486Q@mail.gmail.com>

On Jun 10 2024, Alexei Starovoitov wrote:
> On Sat, Jun 8, 2024 at 2:01 AM Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > +
> > +static int hid_bpf_ops_init_member(const struct btf_type *t,
> > +                                const struct btf_member *member,
> > +                                void *kdata, const void *udata)
> > +{
> > +       u32 moff = __btf_member_bit_offset(t, member) / 8;
> > +       u32 flags;
> > +
> > +       switch (moff) {
> > +       case offsetof(struct hid_bpf_ops, hid_id):
> > +               /* For hid_id and flags fields, this function has to copy it
> > +                * and return 1 to indicate that the data has been handled by
> > +                * the struct_ops type, or the verifier will reject the map if
> > +                * the value of those fields is not zero.
> > +                */
> > +               ((struct hid_bpf_ops *)kdata)->hid_id = ((struct hid_bpf_ops *)udata)->hid_id;
> > +               return 1;
> > +       case offsetof(struct hid_bpf_ops, flags):
> > +               flags = ((struct hid_bpf_ops *)udata)->flags;
> > +               if (flags & ~BPF_F_BEFORE)
> > +                       return -EINVAL;
> > +               ((struct hid_bpf_ops *)kdata)->flags = flags;
> 
> minor nit: I'd cast kdata/udate in the beginning of
> the function to make the lines shorter and less verbose.
> Similar to how bpf_tcp_ca_init_member() does it.

The change looks like:

---
diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 9192c66cde20..dde547e734ed 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -97,8 +97,14 @@ static int hid_bpf_ops_init_member(const struct btf_type *t,
                                 const struct btf_member *member,
                                 void *kdata, const void *udata)
 {
-       u32 moff = __btf_member_bit_offset(t, member) / 8;
-       u32 flags;
+       const struct hid_bpf_ops *uhid_bpf_ops;
+       struct hid_bpf_ops *khid_bpf_ops;
+       u32 moff;
+
+       uhid_bpf_ops = (const struct hid_bpf_ops *)udata;
+       khid_bpf_ops = (struct hid_bpf_ops *)kdata;
+
+       moff = __btf_member_bit_offset(t, member) / 8;
 
        switch (moff) {
        case offsetof(struct hid_bpf_ops, hid_id):
@@ -107,13 +113,12 @@ static int hid_bpf_ops_init_member(const struct btf_type *t,
                 * the struct_ops type, or the verifier will reject the map if
                 * the value of those fields is not zero.
                 */
-               ((struct hid_bpf_ops *)kdata)->hid_id = ((struct hid_bpf_ops *)udata)->hid_id;
+               khid_bpf_ops->hid_id = uhid_bpf_ops->hid_id;
                return 1;
        case offsetof(struct hid_bpf_ops, flags):
-               flags = ((struct hid_bpf_ops *)udata)->flags;
-               if (flags & ~BPF_F_BEFORE)
+               if (uhid_bpf_ops->flags & ~BPF_F_BEFORE)
                        return -EINVAL;
-               ((struct hid_bpf_ops *)kdata)->flags = flags;
+               khid_bpf_ops->flags = uhid_bpf_ops->flags;
                return 1;
        }
        return 0;
---

> 
> Acked-by: Alexei Starovoitov <ast@kernel.org>

And I'm going to apply the series now

Cheers,
Benjamin

