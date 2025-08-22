Return-Path: <linux-kselftest+bounces-39695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6CB31E66
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A5C622D96
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD9922688C;
	Fri, 22 Aug 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Ij8kuW7T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981D211A11;
	Fri, 22 Aug 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875920; cv=none; b=S1bVogznnubNLAlvcLDw7CmnBD6ntYZtGQdg1+tbfVrNl2NC4+VdzxKliJfwALJ+/lveoe/dhn5BV0jSDKVgPdXgnRUlSD04MPidlY6EUhEigvW5EAdiIWkX+zVN3XPQfF4Z57hyJUs7u3jcnhVeToP8++TpPxFYDXgWed1BZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875920; c=relaxed/simple;
	bh=AsisFzk5RpZGo2qHEIH2RFjIZWGpxDMznki/isvR0fY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=TDVCYkdI3fLZRCvXXR7xNsid1cacWH6pJJVzAW7ZLwcWTAl8hJF549E2/S55vJOC1sSVa6mGBqkrp41MOXN1k+6ErEaaFFwhRGMJgTdz+b8+XaMQ3uDuJFzRK7Ezw31Z09xYv2nd/nnGPsP9cK5W+RfgyqfUfalkhtzJkpsQ4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Ij8kuW7T reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=BsZS4lEWMC63rdXE3QSmsW25yOWeMoC6tKATE9okz+Y=; b=I
	j8kuW7TnUPouiKhqvVKCIqRou381+Qf6vrNjxlnEkN6Pzn/PCwN14jSOhphpk50m
	G8j6zOr5kX542yIZxtmr9cbjLB/bVDXVRBFBbqcdsnxIp6XiaeviapCueby8hZrI
	W1C57LfFmIKJvoMjUy5MUPXNTXvEdm5or4+F/eBlWQ=
Received: from phoenix500526$163.com ( [120.230.124.83] ) by
 ajax-webmail-wmsvr-40-140 (Coremail) ; Fri, 22 Aug 2025 23:18:03 +0800
 (CST)
Date: Fri, 22 Aug 2025 23:18:03 +0800 (CST)
From: =?GBK?B?1dS80ey/?= <phoenix500526@163.com>
To: "Jiri Olsa" <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH bpf-next v12 0/2] libbpf: fix USDT SIB argument
 handling causing unrecognized register error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <aKhuA0xklnLCIbsv@krava>
References: <20250821152713.1024982-1-phoenix500526@163.com>
 <aKhuA0xklnLCIbsv@krava>
X-NTES-SC: AL_Qu2eB/ScukAj5SGdZukfmUsVh+o9X8K1vfsk3oZfPJp+jB/o8AU8Z1lMJ1nW+euOIgmlrheYSRJPzuZ6Z7ZSWYANxeMs2NJchFmQHO4hDfC67w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7078a326.98e2.198d25bb89b.Coremail.phoenix500526@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgDXf48siqhoEgYgAA--.2681W
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFBqxiGiogESwtQABs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKT2ssIGRvbmUuCgoKCgoKCgpBdCAyMDI1LTA4LTIyIDIxOjE3OjU1LCAiSmlyaSBP
bHNhIiA8b2xzYWppcmlAZ21haWwuY29tPiB3cm90ZToKPk9uIFRodSwgQXVnIDIxLCAyMDI1IGF0
IDAzOjI3OjEwUE0gKzAwMDAsIEppYXdlaSBaaGFvIHdyb3RlOgo+PiBXaGVuIHVzaW5nIEdDQyBv
biB4ODYtNjQgdG8gY29tcGlsZSBhbiB1c2R0IHByb2cgd2l0aCAtTzEgb3IgaGlnaGVyCj4+IG9w
dGltaXphdGlvbiwgdGhlIGNvbXBpbGVyIHdpbGwgZ2VuZXJhdGUgU0lCIGFkZHJlc3NpbmcgbW9k
ZSBmb3IgZ2xvYmFsCj4+IGFycmF5IGFuZCBQQy1yZWxhdGl2ZSBhZGRyZXNzaW5nIG1vZGUgZm9y
IGdsb2JhbCB2YXJpYWJsZSwKPj4gZS5nLiAiMUAtOTYoJXJicCwlcmF4LDgpIiBhbmQgIi0xQDQr
dDEoJXJpcCkiLgo+PiAKPj4gVGhlIGN1cnJlbnQgVVNEVCBpbXBsZW1lbnRhdGlvbiBpbiBsaWJi
cGYgY2Fubm90IHBhcnNlIHRoZXNlIHR3byBmb3JtYXRzLAo+PiBjYXVzaW5nIGBicGZfcHJvZ3Jh
bV9fYXR0YWNoX3VzZHQoKWAgdG8gZmFpbCB3aXRoIC1FTk9FTlQKPj4gKHVucmVjb2duaXplZCBy
ZWdpc3RlcikuCj4+IAo+PiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIFNJQiBh
ZGRyZXNzaW5nIG1vZGUgaW4gVVNEVCBwcm9iZXMuCj4+IFRoZSBtYWluIGNoYW5nZXMgaW5jbHVk
ZToKPj4gLSBhZGQgY29ycmVjdCBoYW5kbGluZyBsb2dpYyBmb3IgU0lCLWFkZHJlc3NlZCBhcmd1
bWVudHMgaW4KPj4gICBgcGFyc2VfdXNkdF9hcmdgLgo+PiAtIGFkZCBhbiB1c2R0X28yIHRlc3Qg
Y2FzZSB0byBjb3ZlciBTSUIgYWRkcmVzc2luZyBtb2RlLgo+PiAKPj4gVGVzdGluZyBzaG93cyB0
aGF0IHRoZSBTSUIgcHJvYmUgY29ycmVjdGx5IGdlbmVyYXRlcyA4QCglcmN4LCVyYXgsOCkgCj4+
IGFyZ3VtZW50IHNwZWMgYW5kIHBhc3NlcyBhbGwgdmFsaWRhdGlvbiBjaGVja3MuCj4+IAo+PiBU
aGUgbW9kaWZpY2F0aW9uIGhpc3Rvcnkgb2YgdGhpcyBwYXRjaCBzZXJpZXM6Cj4+IENoYW5nZSBz
aW5jZSB2MToKPj4gLSByZWZhY3RvciB0aGUgY29kZSB0byBtYWtlIGl0IG1vcmUgcmVhZGFibGUK
Pj4gLSBtb2RpZnkgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIGV4cGxhaW4gd2h5IGFuZCBob3cKPj4g
Cj4+IENoYW5nZSBzaW5jZSB2MjoKPj4gLSBmaXggdGhlIGBzY2FsZWAgdW5pbml0aWFsaXplZCBl
cnJvcgo+PiAKPj4gQ2hhbmdlIHNpbmNlIHYzOgo+PiAtIGZvcmNlIC1PMiBvcHRpbWl6YXRpb24g
Zm9yIHVzZHQudGVzdC5vIHRvIGdlbmVyYXRlIFNJQiBhZGRyZXNzaW5nIHVzZHQKPj4gICBhbmQg
cGFzcyBhbGwgdGVzdCBjYXNlcy4KPj4gCj4+IENoYW5nZSBzaW5jZSB2NDoKPj4gLSBzcGxpdCB0
aGUgcGF0Y2ggaW50byB0d28gcGFydHMsIG9uZSBmb3IgdGhlIGZpeCBhbmQgdGhlIG90aGVyIGZv
ciB0aGUKPj4gICB0ZXN0Cj4+IAo+PiBDaGFuZ2Ugc2luY2UgdjU6Cj4+IC0gT25seSBlbmFibGUg
b3B0aW1pemF0aW9uIGZvciB4ODYgYXJjaGl0ZWN0dXJlIHRvIGdlbmVyYXRlIFNJQiBhZGRyZXNz
aW5nCj4+ICAgdXNkdCBhcmd1bWVudCBzcGVjLgo+PiAKPj4gQ2hhbmdlIHNpbmNlIHY2Ogo+PiAt
IEFkZCBhbiB1c2R0X28yIHRlc3QgY2FzZSB0byBjb3ZlciBTSUIgYWRkcmVzc2luZyBtb2RlLgo+
PiAtIFJlaW5zdGF0ZSB0aGUgdXNkdC5jIHRlc3QgY2FzZS4KPj4gCj4+IENoYW5nZSBzaW5jZSB2
NzoKPj4gLSBSZWZhY3RvciBtb2RpZmljYXRpb25zIHRvIF9fYnBmX3VzZHRfYXJnX3NwZWMgdG8g
YXZvaWQgaW5jcmVhc2luZyBpdHMgc2l6ZSwKPj4gICBhY2hpZXZpbmcgYmV0dGVyIGNvbXBhdGli
aWxpdHkKPj4gLSBGaXggc29tZSBtaW5vciBjb2RlIHN0eWxlIGlzc3Vlcwo+PiAtIFJlZmFjdG9y
IHRoZSB1c2R0X28yIHRlc3QgY2FzZSwgcmVtb3Zpbmcgc2VtYXBob3JlIGFuZCBhZGRpbmcgR0ND
IGF0dHJpYnV0ZQo+PiAgIHRvIGZvcmNlIC1PMiBvcHRpbWl6YXRpb24KPj4gCj4+IENoYW5nZSBz
aW5jZSB2ODoKPj4gLSBSZWZhY3RvciB0aGUgdXNkdF9vMiB0ZXN0IGNhc2UsIHVzaW5nIGFzc2Vt
Ymx5IHRvIGZvcmNlIFNJQiBhZGRyZXNzaW5nIG1vZGUuCj4+IAo+PiBDaGFuZ2Ugc2luY2Ugdjk6
Cj4+IC0gT25seSBlbmFibGUgdGhlIHVzZHRfbzIgdGVzdCBjYXNlIG9uIHg4Nl82NCBhbmQgaTM4
NiBhcmNoaXRlY3R1cmVzIHNpbmNlIHRoZQo+PiAgIFNJQiBhZGRyZXNzaW5nIG1vZGUgaXMgb25s
eSBzdXBwb3J0ZWQgb24geDg2XzY0IGFuZCBpMzg2Lgo+PiAKPj4gQ2hhbmdlIHNpbmNlIHYxMDoK
Pj4gLSBSZXBsYWNlIGBfX2F0dHJpYnV0ZV9fKChvcHRpbWl6ZSgiTzIiKSkpYCB3aXRoIGAjcHJh
Z21hIEdDQyBvcHRpbWl6ZSgiTzEiKWAKPj4gICB0byBmaXggdGhlIGlzc3VlIHdoZXJlIHRoZSBv
cHRpbWl6ZWQgY29tcGlsYXRpb24gY29uZGl0aW9uIHdvcmtzIGltcHJvcGVybHkuIAo+PiAtIFJl
bmFtZWQgdGVzdCBjYXNlIHVzZHRfbzIgYW5kIHJlbGV2YW50IGZpbGVzIG5hbWUgdG8gdXNkdF9v
MSBpbiB0aGF0IE8xCj4+ICAgbGV2ZWwgb3B0aW1pemF0aW9uIGlzIGVub3VnaCB0byBnZW5lcmF0
ZSBTSUIgYWRkcmVzc2luZyB1c2R0IGFyZ3VtZW50IHNwZWMuCj4+IAo+PiBDaGFuZ2Ugc2luY2Ug
djExOgo+PiAtIFJlcGxhY2UgYFNUQVBfUFJPQkUxYCB3aXRoIGBTVEFQX1BST0JFX0FTTWAKPj4g
LSBVc2UgYml0IGZpZWxkcyBpbnN0ZWFkIG9mIGJpdCBzaGlmdGluZyBvcGVyYXRpb25zCj4+IC0g
TWVyZ2UgdGhlIHVzZHRfbzEgdGVzdCBjYXNlIGludG8gdGhlIHVzZHQgdGVzdCBjYXNlCj4KPmhp
LAo+SSBjYW4gc2VlIHBhdGNoc2V0IHYxMiB0d2ljZSB3aXRoIGRpZmZlcmVudCBzdGF0cy4uIHRo
aXMgb25lJ3MgdGhlIGxhdHRlciwKPmJ1dCB5b3UgbWlnaHQgd2FudCB0byByZXNlbmQgd2l0aCBu
ZXcgdmVyc2lvbgo+Cj5qaXJrYQo+Cj4KPj4gCj4+IEppYXdlaSBaaGFvICgyKToKPj4gICBsaWJi
cGY6IGZpeCBVU0RUIFNJQiBhcmd1bWVudCBoYW5kbGluZyBjYXVzaW5nIHVucmVjb2duaXplZCBy
ZWdpc3Rlcgo+PiAgICAgZXJyb3IKPj4gICBzZWxmdGVzdHMvYnBmOiBFbnJpY2ggc3VidGVzdF9i
YXNpY191c2R0IGNhc2UgaW4gc2VsZnRlc3RzIHRvIGNvdmVyCj4+ICAgICBTSUIgaGFuZGxpbmcg
bG9naWMKPj4gCj4+ICB0b29scy9saWIvYnBmL3VzZHQuYnBmLmggICAgICAgICAgICAgICAgICAg
ICAgfCA0NyArKysrKysrKysrKysrKy0KPj4gIHRvb2xzL2xpYi9icGYvdXNkdC5jICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDU4ICsrKysrKysrKysrKysrKysrLS0KPj4gIHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3VzZHQuYyB8IDQ0ICsrKysrKysrKysrKystCj4+
ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF91c2R0LmMgfCAzMCArKysr
KysrKysrCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDE3MCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQo+PiAKPj4gLS0gCj4+IDIuNDMuMAo+PiAKPj4gCg==

